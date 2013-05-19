class SocialViewController < UIViewController
  extend IB

  def facebookRequest
    url = 'https://graph.facebook.com/me'.nsurl
    params = { fields: 'id,name' }
    request = SLRequest.requestForServiceType(SLServiceTypeFacebook, requestMethod:SLRequestMethodGET, URL:url, parameters:params)
    request.performRequestWithHandler(method(:slRequestHandler).to_proc)
  end

  def twitterRequest
    url = 'https://api.twitter.com/1.1/users/show.json'.nsurl
    params = { screen_name: 'awakia' }
    request = SLRequest.requestForServiceType(SLServiceTypeTwitter, requestMethod:SLRequestMethodGET, URL:url, parameters:params)
    request.performRequestWithHandler(method(:slRequestHandler).to_proc)
  end

  def slRequestHandler(responseData, urlResponse, error)
    p responseData
    p urlResponse
    p error
  end
end
