class Luxe < Formula
  desc "A terminal coding agent: streaming chat, tools, guided diff review, and LSP/DAP code intelligence"
  homepage "https://luxe.dev"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/evanwhittaker/luxe/releases/download/v0.1.1/luxe-cli-aarch64-apple-darwin.tar.xz"
      sha256 "aed3c5e022bc8a782f4b60fa089e93d4afe82336ef5b4106f8b6388af7396054"
    end
    if Hardware::CPU.intel?
      url "https://github.com/evanwhittaker/luxe/releases/download/v0.1.1/luxe-cli-x86_64-apple-darwin.tar.xz"
      sha256 "8206e7723ad8f39cd2f49852d2435dbed8ffec77733fe1ba07f7f2aa4503eb04"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/evanwhittaker/luxe/releases/download/v0.1.1/luxe-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ae0063596baa51911d8fe4dabdf1fd9980bf35d6fd13377ea16bed43580673f3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/evanwhittaker/luxe/releases/download/v0.1.1/luxe-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e13719a93d3867823b086780647fd7fb616fcd9ac9642adfd149d698fcd303a1"
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
