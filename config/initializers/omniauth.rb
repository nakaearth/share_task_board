Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :twitter, "7751092-OeYaTf46Ynnr8bky57Bl2yqVAhIrx6do0ChHhrut4", "08tVad7rwag4ljk30mSXo90rfLBY45KvEBkUbjB1e4Y"
end 
