class SyncContactViewController < UIViewController
  extend IB

  # ナビゲーションバーの代わり
  outlet :navigationBarView, UIView

  # 連絡先を同期したいサービスごとに横に並べる
  outlet :scrollView, UIScrollView

  # Gmail同期ボタン
  outlet :syncGmailButton, UIButton
  # Gmail同期スキップボタン
  outlet :skipSyncGmailButton, UIButton
  # Facebook同期ボタン
  outlet :syncFacebookButton, UIButton
  # Facebook同期スキップボタン
  outlet :skipSyncFacebookButton, UIButton

  def touchedUpInsideWithButton(button)
    if button == @skipSyncGmailButton
      nextPage = @scrollView.contentOffset.x / view.frame.size.width
      self.scrollViewContentOffsetWithNextPage = nextPage
    end
  end

  def scrollViewContentOffsetWithNextPage=(nextPage)
    @scrollView.setContentOffset(CGPointMake(view.frame.size.width * (nextPage + 1), 0), animated: true)
  end

  def loadView
    super
    @navigationBarView.layer.shadowOffset = KNavigationBarShadowOffset
    @navigationBarView.layer.shadowColor = UIColor.blackColor.CGColor
    @navigationBarView.layer.shadowOpacity = KNavigationBarShadowOpacity
    @navigationBarView.layer.shadowPath = UIBezierPath.bezierPathWithRect(@navigationBarView.bounds).CGPath

    @scrollView.setContentSize(CGSizeMake(self.view.frame.size.width * KSyncContactCount, self.view.frame.size.height - KNavigationBarDefaultHeight))
  end

end

