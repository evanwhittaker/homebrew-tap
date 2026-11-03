class Luxe < Formula
  desc "A coding agent for your terminal."
  homepage "https://luxe.dev"
  version "0.1.9"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/evanwhittaker/luxe/releases/download/v0.1.9/luxe-cli-aarch64-apple-darwin.tar.xz"
      sha256 "ccd66ff4f71fa196edd7ad1c6f1860d3095fb4946e4af39ab3ef44e907634927"
    end
    if Hardware::CPU.intel?
      url "https://github.com/evanwhittaker/luxe/releases/download/v0.1.9/luxe-cli-x86_64-apple-darwin.tar.xz"
      sha256 "35ccefcf0f47a86d1d9f7378c18d15427df2c11612d1bca13afa84d974242415"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/evanwhittaker/luxe/releases/download/v0.1.9/luxe-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ab29dea67ab22e881f176eaa44b7abf787da52bd0fdcae343d5c2f8b3d0186bb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/evanwhittaker/luxe/releases/download/v0.1.9/luxe-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "aaf8cc7fcf11ef9d32b92284c3a3a6b23cfb3fe0ba922bbfdeffd1b3b29573e1"
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
