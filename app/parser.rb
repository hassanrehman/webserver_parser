class Parser
  def initialize(arguments)
    @file_reader = FileReader.new(arguments)
  end

  def run
    puts ordered_paths.map { |p| p.join(" ") }
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
