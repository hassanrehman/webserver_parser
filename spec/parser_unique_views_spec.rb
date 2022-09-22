RSpec.describe Parser do
  subject { described_class.new(arguments).unique_views }

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

  context 'Unique views for unique pages' do
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

  context 'Same Unique viewers for repeated pages' do
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
          ["/home", 1],
          ["/index", 1],
          ["/show", 1],
        ]
      )
    end
  end
  
  context 'Unique viewers for repeated pages' do
    let(:lines) do
      [
        "/home 1.1.1.1",
        "/index 1.1.1.1",
        "/show 1.1.1.1",
        "/index 1.1.1.2",
        "/show 1.1.1.1",
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
end
