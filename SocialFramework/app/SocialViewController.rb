class SocialViewController < UIViewController
  extend IB

  def getFacebookPermission
    getFacebookPermissionWithPrivileges(['email'])
  end

  def getFacebookPermissionWithPrivileges(privileges)
    @accountStore ||= ACAccountStore.new
    @facebookAccountType = @accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierFacebook)
    options = {
      ACFacebookAppIdKey => NSBundle.mainBundle.objectForInfoDictionaryKey('FACEBOOK_APP_ID'),  # app id
      ACFacebookPermissionsKey => privileges,
      ACFacebookAudienceKey => ACFacebookAudienceOnlyMe  # scope of disclosure
    }
    @accountStore.requestAccessToAccountsWithType(
      @facebookAccountType,
      options:options, completion: lambda do |granted, error|
        if granted
          accounts = @accountStore.accountsWithAccountType(@facebookAccountType)
          @facebookAccount = accounts.lastObject
          @facebookCredential = @facebookAccount.credential
          @facebookToken = @facebookCredential.oauthToken
          NSLog('Auth Success! fbAccessToken : %@', @facebookToken)
        else
          # see http://stackoverflow.com/questions/12630066/acaccountstore-error-6-and-8
          NSLog('error code : %@', error)
          if error.code == 6
            # http://stackoverflow.com/questions/14137902/how-do-display-a-uialertview-from-a-block-on-ios
            # http://pochixpochi.blogspot.jp/2012/05/rubymotiongcd.html
            Dispatch::Queue.main.async do
              UIAlertView.alloc.initWithTitle('Error', message:"Please set up Facebook account!", delegate:nil, cancelButtonTitle:'OK', otherButtonTitles:nil).show
            end
            NSLog("Please set up Facebook Account!")
            # # http://stackoverflow.com/questions/14145322/ios-6-social-framework-not-going-to-settings-or-no-alert
            # # SLComposeViewController.presentViewController show account setting alert by default,
            # # but there is not the way to call that alert manually for now...
            # mySLComposerSheet = SLComposeViewController.composeViewControllerForServiceType(SLServiceTypeFacebook)
            # mySLComposerSheet.setInitialText("")
            # self.presentViewController(mySLComposerSheet, animated:true, completion:nil)

            # Even if the error "CGImageCreate: invalid image size: 0 x 0" occurs in simulator,
            # it does not happen in actual device (http://sugumura.hatenablog.com/entry/2013/04/09/151131)
          else
            Dispatch::Queue.main.async do
              UIAlertView.alloc.initWithTitle('Error', message:error.localizedDescription, delegate:nil, cancelButtonTitle:'OK', otherButtonTitles:nil).show
            end
            NSLog("Error accessing account: %s", error.localizedDescription)
          end
        end
      end
    )
  end

  def getTwitterPermission
    @accountStore ||= ACAccountStore.new
    @twitterAccountType = @accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
    @accountStore.requestAccessToAccountsWithType(
      @twitterAccountType,
      options:nil, completion: lambda do |granted, error|
        if granted
          accounts = @accountStore.accountsWithAccountType(@twitterAccountType)
          @twitterAccount = accounts.lastObject
          NSLog('Auth Success!')
        else
          NSLog('error code : %@', error)
          Dispatch::Queue.main.async do
            UIAlertView.alloc.initWithTitle('Error', message:error.localizedDescription, delegate:nil, cancelButtonTitle:'OK', otherButtonTitles:nil).show
          end
        end
      end
    )
  end

  def facebookRequest
    return unless @facebookAccount
    url = 'https://graph.facebook.com/me'.nsurl
    params = { fields: 'id,name' }
    request = SLRequest.requestForServiceType(SLServiceTypeFacebook, requestMethod:SLRequestMethodGET, URL:url, parameters:params)
    request.setAccount(@facebookAccount)
    request.performRequestWithHandler(method(:slRequestHandler).to_proc)
  end

  def twitterRequest
    return unless @twitterAccount
    url = 'https://api.twitter.com/1.1/users/show.json'.nsurl
    params = { screen_name: 'awakia' }
    request = SLRequest.requestForServiceType(SLServiceTypeTwitter, requestMethod:SLRequestMethodGET, URL:url, parameters:params)
    request.setAccount(@twitterAccount)
    request.performRequestWithHandler(method(:slRequestHandler).to_proc)
  end

  def slRequestHandler(responseData, urlResponse, error)
    p responseData
    p urlResponse
    p error
  end
end
