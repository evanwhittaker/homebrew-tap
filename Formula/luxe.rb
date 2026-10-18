class Luxe < Formula
  desc "A terminal coding agent: streaming chat, tools, guided diff review, and LSP/DAP code intelligence"
  homepage "https://luxe.dev"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/evanwhittaker/luxe/releases/download/v0.1.2/luxe-cli-aarch64-apple-darwin.tar.xz"
      sha256 "98d7d4b2bb85c2ee5816d8c9ed09d548e087c1a1529c160514402f8bb3bec0d0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/evanwhittaker/luxe/releases/download/v0.1.2/luxe-cli-x86_64-apple-darwin.tar.xz"
      sha256 "640fd20db2d7a71fb0d88ed4e68bec468e97688b89ba94beaecc63d215889bdf"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/evanwhittaker/luxe/releases/download/v0.1.2/luxe-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0c42a0a7eea583b1db20e174b72a31087555f9b5a16469a55cb8c47b7beab0f3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/evanwhittaker/luxe/releases/download/v0.1.2/luxe-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4280c8684ccab2a2d4a22d095b32cd6ddd74af9cd2836fc56d50baaa6a203154"
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
