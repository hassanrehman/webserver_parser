RSpec.describe Parser do
  subject { described_class.new(arguments).visits }

  # Setting base as happy case, one file as argument, no lines in it
  let(:arguments) { [input_file.path] }
  let(:input_file) do
    Tempfile.new('csv').tap do |f|
      f.print lines.join("\n")
    ensure
      f.close
    end
  end
  let(:lines) { [] }

  after { input_file.unlink }

  context 'Ordered lines, no repetition' do
    let(:lines) do
      [
        "/home 1.1.1.1",
        "/index 1.1.1.1",
        "/show 1.1.1.1",
      ]
    end

    it('runs') do
      expect(subject).to eq(
        [
          ["/home", 1],
          ["/index", 1],
          ["/show", 1],
        ]
      )
    end
  end

  context 'Junk in lines' do
    let(:lines) do
      [
        "/home 1.1.1.1",
        "abracadabra web server junk",
        "/show 1.1.1.1",
      ]
    end

    it('runs') do
      expect(subject).to eq(
        [
          ["/home", 1],
          ["/show", 1],
        ]
      )
    end
  end

  context 'Repeated lines' do
    let(:lines) do
      [
        "/home 1.1.1.1",
        "/index 1.1.1.1",
        "/show 1.1.1.1",
        "/index 1.1.1.1",
      ]
    end

    it('runs') do
      expect(subject).to eq(
        [
          ["/index", 2],
          ["/home", 1],
          ["/show", 1],
        ]
      )
    end
  end

  context 'Only one path' do
    let(:lines) do
      [
        "/home 1.1.1.1",
        "/home 1.1.1.1",
        "/home 1.1.1.1",
      ]
    end

    it('runs') do
      expect(subject).to eq(
        [
          ["/home", 3],
        ]
      )
    end
  end
end
