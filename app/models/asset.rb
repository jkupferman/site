require 'rvideo'

class Asset < ActiveRecord::Base

  belongs_to :asset_type

  belongs_to :video

  has_many :streaming_for, :class_name => 'Video'

  has_attached_file :data,
    :path => ":rails_root/public/system/:class/:attachment/:id/:style/:basename.:extension",
    :url => "/system/:class/:attachment/:id/:style/:basename.:extension"

  named_scope :downloadable,
    :joins => :asset_type,
    :conditions => ['asset_types.downloadable = ?', true],
    :order => 'data_file_size desc'

  def raw_response
    if @raw_response.nil?
      get_metadata
    end
    @raw_response
  end

  def width
    if @width.nil?
      get_metadata
    end
    @width.to_i
  end

  def height
    if @height.nil?
      get_metadata
    end
    @height.to_i
  end

  def duration
    if @duration.nil?
      get_metadata
    end
    @duration
  end

  def size
    if width > 0 and height > 0
      "#{width}x#{height}"
    else
      ""
    end
  end

  def display_description
    hlp = Object.new.extend(ActionView::Helpers::NumberHelper)
    elements = Array.new
    if asset_type && asset_type.description == "Video" then
      elements << (description.blank? ? nil : description)
      elements << size
      elements << data_content_type
      elements << hlp.number_to_human_size(data_file_size)
      elements << duration
      elements.compact.join(" - ")
    elsif asset_type && asset_type.description == "Audio" then
      elements << (description.blank? ? nil : description)
      elements << data_content_type
      elements << hlp.number_to_human_size(data_file_size)
      elements << duration
      elements.compact.join(" - ")
    else
      if description.blank?
        "no description available"
      else
        description
      end
    end
  end

  def get_metadata
    if data
      file = data.path

      begin
        tmp1 = RVideo::Inspector.new :file => file

        @raw_response = tmp1.raw_response

        pos1 = (tmp1.raw_response =~ /Duration:/)

        unless pos1.nil?
          @duration = tmp1.raw_response[(pos1 + 10),8]
        else
          @duration =""
        end

        pos2 = (tmp1.raw_response =~ /Video:/)

        unless pos2.nil?
          tmp2 = tmp1.raw_response[pos2,50]
          @width, @height = tmp2[(tmp2 =~ /x/) - 4, 9].split(',')[0].split('x')
        else
          @width = 0
          @height = 0
        end
      rescue
        @width = 0
        @height = 0
        @duration = 0
      end
      true
    else
      false
    end
  end
end
