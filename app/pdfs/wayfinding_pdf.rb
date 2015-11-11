class WayfindingPdf < Prawn::Document

  require "open-uri"



  def initialize(wayfinding)
    super(:page_size => "A3",)
    font_families.update(
      "PredigeRounded" => {
        :normal => "#{Rails.root.to_s}/public/fonts/PredigeRounded-Medium.ttf"
      }
    )
    @wayfindings = wayfinding
    header
    text_content
  end

  def header
    #This inserts an image in the pdf file and sets the size of the image
  end

  def text_content
    # The cursor for inserting content starts on the top left of the page. Here we move it down a little to create more space between the text and the image inserted above
    y_position = cursor - 50

    # The bounding_box takes the x and y coordinates for positioning its content and some options to style it
    bounding_box([0, y_position], :width => 1000, :height => 1500) do

      @wayfindings.each do |wayfinding|

        pad_bottom(20) { 
          font('PredigeRounded')
          text "#{wayfinding.first_content}", size: 200, style: :normal
        }
        pad_bottom(20) { 
          font('PredigeRounded')
          text "#{wayfinding.second_content}", size: 200, style: :normal
        }
        pad_bottom(20) { 
          font('PredigeRounded')
          text "#{wayfinding.third_content}", size: 200, style: :normal
        }
        start_new_page
      end
    end

    bounding_box([0, 200], :width => 230, :height => 00) do
    end

  end


end