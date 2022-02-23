class Spc < Formula
  version "1.1.1"
  desc "A spotify CLI"
  homepage "https://github.com/dvdmuckle/spc"

  if Hardware::CPU.intel?
    if OS.mac?
      url "https://github.com/dvdmuckle/spc/releases/download/#{version}/spc-#{version}-darwin-amd64.tar.gz"
      sha256 "58ae3964ca15acb67162562ca65c8b86f06344457bcaeb076cbe27ae565851a6"
    elsif OS.linux?
      url "https://github.com/dvdmuckle/spc/releases/download/#{version}/spc-#{version}-linux-amd64.tar.gz"
      sha256 "427b08adb22ca8fb46a54d7df599e1f558a5f4e6c9493a2bfb75a5a091e672f2"
    end
  end
  if Hardware::CPU.arm?
    if OS.mac?
      url "https://github.com/dvdmuckle/spc/releases/download/#{version}/spc-#{version}-darwin-arm64.tar.gz"
      sha256 "14eb8680efab7a907de0412ae0bfa6e62df20dd67c658d635256908d94134278"
    elsif OS.linux?
      url "https://github.com/dvdmuckle/spc/releases/download/#{version}/spc-#{version}-linux-arm64.tar.gz"
      sha256 "c3ea843d3ca5a55f710ecd3aec4670053545b295c9cb5585456c51810ddb423b"
    end
  end

  def install
    bin.install "spc"

    output = Utils.safe_popen_read({ "SHELL" => "bash" }, bin/"spc", "completion", "bash")
    (bash_completion/"spc").write output

    output = Utils.safe_popen_read({ "SHELL" => "zsh" }, bin/"spc", "completion", "zsh")
    (zsh_completion/"_spc").write output

    system bin/"spc", "docs", "man", "man1"
    man.install "man1"
end

end
