class Spc < Formula
  desc "Lightweight Spotify CLI"
  homepage "https://github.com/dvdmuckle/spc"
  url "https://github.com/dvdmuckle/spc/archive/refs/tags/1.3.0.tar.gz"
  sha256 "1695c8668de159df99615a20e4bd9dde36e06085ce81dab59259946508c446e0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/dvdmuckle/tap"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "6fbd8caea942d47a8a393f09176199dd0e3663a9a38c3bc4184e0186cffa278c"
    sha256 cellar: :any_skip_relocation, ventura:      "c87e80e0aa879fc1a3ee8c63e63fa5227e10cdf03bccefcdde5ad77b5e52b6a9"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9f43e4e013ab261c918a0338e0ede748fe80a448374a4afdc0af2b8d9376b5d7"
  end
  depends_on "go" => :build

  def install
    system "go", "build", "-o", "spc", "-ldflags", "-X github.com/dvdmuckle/spc/cmd.version=#{version}"
    bin.install "spc"

    generate_completions_from_executable(bin/"spc", "completion")

    system bin/"spc", "docs", "man", "man1"
    man.install "man1"
  end
end
