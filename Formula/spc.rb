class dvdmuckle < Formula
  version "v0.4"
  desc "A spotify daemon"
  homepage "https://github.com/dvdmuckle/spc"

  bottle :unneeded

  if OS.mac?
    url "https://github.com/dvdmuckle/spc/releases/download/v#{version}/spc_v#{version}_darwin_amd64.tar.gz"
    sha256 "f06c4fd3ce9bf2d4cf72f0240c1595b9f10c179d5b269d7c9a94a1a93f0465e7"
  elsif OS.linux?
    url "https://github.com/dvdmuckle/spc/releases/download/v#{version}/spc_v#{version}_linux_amd64.tar.gz"
    sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
end

  def install
    bin.install "spc"
end

end
