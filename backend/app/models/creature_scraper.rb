require 'nokogiri'
require 'open-uri'
class CreatureScraper

  def initialize(path, c_type, h_type)
    @doc = Nokogiri::HTML(open(path))
    @type = c_type
    @hemisphere = h_type
  end

  def self.scrape
    base_path = "https://animalcrossing.fandom.com/wiki/"
    fish_path = "Fish_(New_Horizons)"
    bug_path = "Bugs_(New_Horizons)"
    CreatureScraper.new("#{base_path}#{fish_path}", :fish, "north").call
    CreatureScraper.new("#{base_path}#{fish_path}", :fish, "south").call

    # todo - html structure is different
    # CreatureScraper.new("#{base_path}#{bug_path}", :bug, "north").call
    # CreatureScraper.new("#{base_path}#{bug_path}", :bug, "south").call
  end

  def call
    rows.each do |row_doc|
      creature = nil
      if @hemisphere == "south"
        creature = Creature.find_by(name: row_doc[0].text.lstrip.gsub("\n", "").downcase)
      else
        case @type
          when :bug
            creature = Creature.create(scrape_bug_row(row_doc))
          when :fish
            creature = Creature.create(scrape_fish_row(row_doc))
        end
      end
      creature.hemispheres.build(scrape_hemisphere(row_doc))
      creature.save
        # TODO save check
    end
  end

  private
    def rows
      title = ''
      if @hemisphere == "north"
        title = "Northern"
      else
        title = "Southern"
      end
      table = @doc.xpath("//div[@title='#{title} Hemisphere']").css('table.roundy.sortable')
      @rows ||= table.css("tr").collect { |row| row.css("td") }.filter { |array| !array.empty? }
    end

    def scrape_fish_row(row)
      {
        c_type: :fish,
        :name => row[0].text.lstrip.gsub("\n", "").downcase,
        :url => row[0].css("a").attribute("href").value,
        :image_url => row[1].css("img").attribute("src").value,
        :price => row[2].text.lstrip.gsub("\n", ""),
        :location => row[3].text.lstrip.gsub("\n", ""),
        :shadow_size => row[4].text.lstrip.gsub("\n", ""),
        :time => row[5].text.lstrip.gsub("\n", "")
      }
    end

    def scrape_bug_row(row)
      {
        c_type: :bug,
        :name => row[0].text.lstrip.gsub("\n", ""),
        :url => row[0].css("a").attribute("href").value,
        :image_url => row[1].css("img").attribute("src").value,
        :price => row[2].text.lstrip.gsub("\n", ""),
        :location => row[3].text.lstrip.gsub("\n", ""),
        :time => row[4].text.lstrip.gsub("\n", ""),
      }
    end

    def scrape_hemisphere(row)
      {
        h_type: @hemisphere,
        january: row[6].text.lstrip.gsub("\n", "") == "-" ? false : true,
        february: row[7].text.lstrip.gsub("\n", "") == "-" ? false : true,
        march: row[8].text.lstrip.gsub("\n", "") == "-" ? false : true,
        april: row[9].text.lstrip.gsub("\n", "") == "-" ? false : true,
        may: row[10].text.lstrip.gsub("\n", "") == "-" ? false : true,
        june: row[11].text.lstrip.gsub("\n", "") == "-" ? false : true,
        july: row[12].text.lstrip.gsub("\n", "") == "-" ? false : true,
        august: row[13].text.lstrip.gsub("\n", "") == "-" ? false : true,
        september: row[14].text.lstrip.gsub("\n", "") == "-" ? false : true,
        october: row[15].text.lstrip.gsub("\n", "") == "-" ? false : true,
        november: row[16].text.lstrip.gsub("\n", "") == "-" ? false : true,
        december: row[17].text.lstrip.gsub("\n", "") == "-" ? false : true
      }

    end

    def make_int(value)
      value.delete(",").to_i
    end

    def self.destroy
      Creature.destroy_all
      Hemisphere.destroy_all
    end
end

# c.all.map { |c| puts c.name }