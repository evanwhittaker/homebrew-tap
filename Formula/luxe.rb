class Luxe < Formula
  desc "A terminal coding agent: streaming chat, tools, guided diff review, and LSP/DAP code intelligence"
  homepage "https://luxe.dev"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/evanwhittaker/luxe/releases/download/v0.1.0/luxe-cli-aarch64-apple-darwin.tar.xz"
      sha256 "bcc16105ed8355357946804165cbefdc05c51439d57edc3cfa5673e83afade3e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/evanwhittaker/luxe/releases/download/v0.1.0/luxe-cli-x86_64-apple-darwin.tar.xz"
      sha256 "e02d140e8e05d37240421acd9fd3a9bdd602b112896e42cb2acea3666d4eef60"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/evanwhittaker/luxe/releases/download/v0.1.0/luxe-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2aa2e1a4d133a9a73a2b5a2b7f03b5fc4b8aee3a75d3c8e64b4f53315afbc0ea"
    end
    if Hardware::CPU.intel?
      url "https://github.com/evanwhittaker/luxe/releases/download/v0.1.0/luxe-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9547d68f760d676cef0a27c245ae4e840fd78edd53f64a763e769659a90803c6"
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
