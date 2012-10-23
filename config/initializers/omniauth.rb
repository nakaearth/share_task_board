Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :twitter, "ChP1EObHemu4Z7hgGuQAQ", "5143KtC6kAGfFYOYUweRUqmevdl04VgTtED2RIac"
end 
