class CompanyPdf < Prawn::Document

  require "open-uri"



  def initialize(companies)
    super(:page_size => "A6",)
    font_families.update(
      "TitilliumWeb" => {
        :normal => "#{Rails.root.to_s}/public/fonts/TitilliumWeb-Regular.ttf",
        :bold => "#{Rails.root.to_s}/public/fonts/TitilliumWeb-Bold.ttf"  
      },
      "PredigeRounded" => {
        :normal => "#{Rails.root.to_s}/public/fonts/PredigeRounded-Medium.ttf"
      }
    )
    @companies = companies
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
    bounding_box([0, y_position], :width => 230, :height => 400) do

      @companies.each do |company|

        pad_bottom(20) { 
          font('PredigeRounded')
          text "#{company.name}", size: 15, style: :normal
        }
        pad_bottom(20) { 
          font('TitilliumWeb')
          text "#{company.mission}", size: 12 
        }
        if company.tech_stack.present?
          text "TECH STACK", size: 5, style: :bold
          pad_bottom(20) { text "#{company.tech_stack}", size: 8 }
        end
        text "OPEN POSITIONS", size: 5, style: :bold
        pad_bottom(20) { 
          text "#{company.hiring_saturday}, #{company.hiring_sunday}", size: 8 
        }
        text "HIRING CONTACT", size: 5, style: :bold
        pad_bottom(20) { 
          text "#{company.hiring_contact}", size: 8 
        }
        bounding_box([0, 100], :width => 100, :height => 100) do
          image "#{Rails.root}/app/assets/images/team.png", width: 10, height: 10 
          bounding_box([20, 100], :width => 100, :height => 100) do
            text "#{company.team_size}", size: 8 
          end
        end
        bounding_box([50, 100], :width => 100, :height => 100) do
          image "#{Rails.root}/app/assets/images/founded.png", width: 10, height: 10
          bounding_box([20, 100], :width => 100, :height => 100) do
            text "#{company.founded}", size: 8 
          end
        end
        bounding_box([200, 100], :width => 100, :height => 100) do
          if company.saturday == "TRUE"
            text "SAT", size: 8
          else
          end
          if company.sunday  == "TRUE"
            text "SUN", size: 8
          else
          end
          text "Pitch no: #{company.pitch}", size: 8
        end
        start_new_page
      end
    end

    bounding_box([0, 200], :width => 230, :height => 00) do
    end

  end


end