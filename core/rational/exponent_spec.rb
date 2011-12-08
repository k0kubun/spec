ruby_version_is "1.9" do
  require File.expand_path('../../../shared/rational/exponent', __FILE__)

  describe "Rational#**" do
    it_behaves_like(:rational_exponent, :**)
  end
end
