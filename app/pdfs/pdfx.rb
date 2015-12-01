require 'prawn'
require 'prawn/measurements'

# I have a small collection of links to the resources I used to figure all
# this out: http://pinboard.in/u:fidothe/t:pdfx
module PDFX
  class PageBox
    include Prawn::Measurements

    attr_reader :bleed_mm

    def initialize(width, height, bleed)
      @width_mm = width
      @height_mm = height
      @bleed_mm = bleed
    end

    def trim_dimensions_mm
      [@width_mm, @height_mm]
    end

    def bleed_dimensions_mm
      trim_dimensions_mm.map { |d| d + 2*bleed_mm }
    end

    alias_method :media_dimensions_mm, :bleed_dimensions_mm

    def bleed_dimensions
      mm_bbox_to_pts(bleed_dimensions_mm)
    end

    alias_method :media_dimensions, :bleed_dimensions

    def trim_box_mm
      [bleed_mm, bleed_mm] + trim_dimensions_mm.map { |d| d + bleed_mm }
    end

    def bleed_box_mm
      [0, 0] + bleed_dimensions_mm
    end

    alias_method :media_box_mm, :bleed_box_mm

    def trim_box
      mm_bbox_to_pts(trim_box_mm)
    end

    def bleed_box
      mm_bbox_to_pts(bleed_box_mm)
    end

    alias_method :media_box, :bleed_box

    private

    def mm_bbox_to_pts(bbox)
      bbox.map { |d| mm2pt(d).round(3) }
    end
  end

  class ICCProfileInfo
    attr_reader :registry_name, :output_condition_identifier, :info, :output_condition, :profile_bytes

    def initialize(attrs = {})
      [:registry_name, :output_condition_identifier,
        :info, :output_condition].each do |attr_name|
        instance_variable_set(:"@#{attr_name}", attrs.fetch(attr_name))
      end

      @profile_bytes = Pathname.new(attrs.fetch(:profile)).binread
    end
  end

  # IIRC, I got these values by examining the metadata in an InDesign
  # generated PDF/X document
  #
  # You can download the ICC files themselves from Adobe at
  # http://www.adobe.com/support/downloads/iccprofiles/iccprofiles_win.html
  FOGRA39 = ICCProfileInfo.new({
    registry_name: "http://www.color.org",
    output_condition_identifier: "FOGRA39",
    info: "Coated FOGRA39 (ISO 12647-2:2004)",
    output_condition: "Offset commercial and specialty printing according to ISO 12647-2:2004 / Amd 1, paper type 1 or 2 (gloss or matte coated offset, 115 g/m2), screen frequency 60/cm.",
    profile: Rails.root + 'app/pdfs/CoatedFOGRA39.icc'
  })

  class Document
    PDFX_VERSION = 'PDF/X-1a:2003'

    def self.generate(path, title)
      doc = new(path)
      yield(doc)
      doc.render_file(path)
    end

    attr_reader :pdf, :title

    def initialize(title)
      @title = title
      @pdf = Prawn::Document.new(skip_page_creation: true, info: info_keys)
      add_pdfx_metadata!
    end

    def start_new_page(page_box, opts = {})
      pdf.start_new_page(opts.merge(size: page_box.media_dimensions))
      pdf.page.dictionary.data[:BleedBox] = page_box.bleed_box
      pdf.page.dictionary.data[:TrimBox] = page_box.trim_box
    end

    def method_missing(name, *args)
      pdf.send(name, *args)
    end

    private

    def add_pdfx_metadata!
      pdf.state.trailer = trailer_keys
      add_output_intents!
    end

    def add_output_intents!
      # The data here declares this a CMYK PDF/X ICC profile- 4 colours,
      # with each having a value range of 0-1
      # Then we add and compress the bytes of the ICC profile itself
      profile = pdf.ref!({N: 4, Range: [0, 1, 0, 1, 0, 1, 0, 1]})
      profile << FOGRA39.profile_bytes
      profile.stream.compress!
      intent = [{
        Type: :OutputIntent,
        S: :GTS_PDFX,
        RegistryName: PDF::Core::LiteralString.new(FOGRA39.registry_name),
        OutputConditionIdentifier: PDF::Core::LiteralString.new(FOGRA39.output_condition_identifier),
        Info: PDF::Core::LiteralString.new(FOGRA39.info),
        OutputCondition: PDF::Core::LiteralString.new(FOGRA39.output_condition),
        DestOutputProfile: profile
      }]
      pdf.state.store.root.data[:OutputIntents] = intent
    end

    def trailer_keys
      id = SecureRandom.uuid
      {ID: [id, id]}
    end

    def pdfx_keys(info_dict)
      info_dict.merge({GTS_PDFXVersion: PDFX_VERSION, GTS_PDFXConformance: PDFX_VERSION})
    end

    def trapped_key(info_dict)
      info_dict.merge({Trapped: :False})
    end

    def title_key(info_dict)
      info_dict.merge({Title: title})
    end

    def date_keys(info_dict)
      time = Time.now
      info_dict.merge({ModDate: time, CreationDate: time})
    end

    def info_keys
      date_keys(title_key(pdfx_keys(trapped_key({}))))
    end
  end
end

# USAGE:

# A4 = PDFX::PageBox.new(210, 297, 3)

# PDFX::Document.generate('pdfx.pdf', 'My PDF/X document') do |pdf|
#   pdf.start_new_page(A4, margin: 0)
#   pdf.fill_color(100, 0, 0, 0)
#   pdf.text "HELLO PDF/X"
# end