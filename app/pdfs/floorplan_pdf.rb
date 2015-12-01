class FloorplanPdf < Prawn::Document

  require "open-uri"



  def initialize(company)
    super(:page_size => "A4",)
    font_families.update(
      "TitilliumWeb" => {
        :normal => "#{Rails.root.to_s}/public/fonts/TitilliumWeb-Regular.ttf",
        :bold => "#{Rails.root.to_s}/public/fonts/TitilliumWeb-Bold.ttf"  
      },
      "PredigeRounded" => {
        :normal => "#{Rails.root.to_s}/public/fonts/PredigeRounded-Medium.ttf"
      }
    )
    @companies = company
    header
    text_content
  end

  def header
    #This inserts an image in the pdf file and sets the size of the image
    image "#{Rails.root}/app/assets/images/floorplan.jpg", height: 390
  end

  def text_content
    # The cursor for inserting content starts on the top left of the page. Here we move it down a little to create more space between the text and the image inserted above
    y_position = cursor - 50

    # The bounding_box takes the x and y coordinates for positioning its content and some options to style it

    column_box([0, y_position], :width => 500, :height => 350, reflow_margins: true, columns: 5) do
      @companies.each do |company|
        text "#{company.pitch}, #{company.name}", size: 8
        
      end
    end

    bounding_box([0, 200], :width => 230, :height => 00) do
    end

  end


end