class Luxe < Formula
  desc "A coding agent for your terminal."
  homepage "https://luxe.dev"
  version "0.1.8"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/evanwhittaker/luxe/releases/download/v0.1.8/luxe-cli-aarch64-apple-darwin.tar.xz"
      sha256 "e3b25fcf959d78b4845ba5bfbda7b4fe77d5606bc08f4556685959b17b67dd59"
    end
    if Hardware::CPU.intel?
      url "https://github.com/evanwhittaker/luxe/releases/download/v0.1.8/luxe-cli-x86_64-apple-darwin.tar.xz"
      sha256 "1e553b86055fdd38aa99a5a8b79e852343bb6bb98534364df0c0d187e3c2dfa3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/evanwhittaker/luxe/releases/download/v0.1.8/luxe-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0a3d6c8812d4e1725c3f453a8d3922106d6e75139c2f2f984a19751c1a1301b5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/evanwhittaker/luxe/releases/download/v0.1.8/luxe-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f6762ac672068925414d495332fe0f47262383388ba7b0201a33a4e26a76505e"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "luxe"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "luxe"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "luxe"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "luxe"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
