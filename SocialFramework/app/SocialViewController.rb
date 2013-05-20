class SocialViewController < UIViewController
  extend IB

  def facebookAccount
    return @facebookAccount if @facebookAccount

    accountStore = ACAccountStore.new
    facebookAccountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierFacebook)
    options = {
      ACFacebookAppIdKey => NSBundle.mainBundle.objectForInfoDictionaryKey('FACEBOOK_APP_ID'),  # app id
      ACFacebookPermissionsKey => ['email'],  # read privileges
      ACFacebookAudienceKey => ACFacebookAudienceOnlyMe  # scope of disclosure
    }
    accountStore.requestAccessToAccountsWithType(
      facebookAccountType,
      options:options, completion:->(granted, error) do
        if granted
          accounts = accountStore.accountsWithAccountType:facebookAccountType
          @facebookAccount = accounts.lastObject
          @facebookCredential = @facebookAccount.credential
          @facebookToken = @facebookCredential.oauthToken
          NSLog('fbAccessToken : %@', facebookToken)
        else
          NSLog('error getting permission : %@', error)
        end
      end
    )
    @facebookAccount
  end


  def facebookRequest
    url = 'https://graph.facebook.com/me'.nsurl
    params = { fields: 'id,name' }
    request = SLRequest.requestForServiceType(SLServiceTypeFacebook, requestMethod:SLRequestMethodGET, URL:url, parameters:params)
    request.setAccount(self.facebookAccount)
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
