class Parser
  def initialize(arguments)
    @file_reader = FileReader.new(arguments)
  end

  # Gethers content and prints
  def run
    puts "list of webpages with most page views ordered DESC"
    puts visits.map { |path, count| "#{path} #{count}" }

    puts "\n\nlist of webpages with most unique page views DESC"
    puts unique_views.map { |path, count| "#{path} #{count}" }
  end

  def visits
    populate!

    @content.transform_values { |visitors| visitors.values.sum }
      .to_a
      .sort_by { |path, count| [-1 * count, path] }
  end

  def unique_views
    populate!

    @content.transform_values(&:count)
      .to_a
      .sort_by { |path, count| [-1 * count, path] }
  end

  private

  # Reads the @input_file and populates the structure:
  #   { path: { visitor: count_of_views } }
  #
  def populate!
    return @content if @populated

    @populated = true
    @content = Hash.new { |h, k| h[k] = Hash.new { |h1, k1| h1[k1] = 0 } }

    @file_reader.call do |page, ip|
      @content[page][ip] += 1
    end
    @content
  end
end
