class TutorialViewController < UIViewController
  extend IB

  # チュートリアルページ数
  KTutorialPageCount = 4

  # チュートリアルを横に並べる
  outlet :scrollView, UIScrollView

  # チュートリアルの今見ているページを表示
  outlet :pageControl, UIPageControl

  # チュートリアル完了ボタン背景View
  outlet :completeButtonBackgroundView, UIView

  # チュートリアル完了ボタン押下
  def touchedUpInsideWithCompleteButton(completeButton)
    # チュートリアル終了
    NSNotificationCenter.defaultCenter.postNotificationName(KNotificationTutorialDidFinished, object: self, userInfo: nil)
  end

  def loadView
    super
    # スクロールビュー
    @scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * KTutorialPageCount, self.scrollView.frame.size.height)
    @pageControl.numberOfPages = KTutorialPageCount

    # シャドー
    @completeButtonBackgroundView.layer.shadowOffset = CGSizeMake(0.0, -1.0)
    @completeButtonBackgroundView.layer.shadowColor = UIColor.blackColor.CGColor
    @completeButtonBackgroundView.layer.shadowOpacity = 0.3
    @completeButtonBackgroundView.layer.shadowPath = UIBezierPath.bezierPathWithRect(@completeButtonBackgroundView.bounds).CGPath
  end

  def scrollViewDidScroll(scrollView)
    # 今いるページの位置を表示
    page = @scrollView.contentOffset.x / @scrollView.frame.size.width;
    if page < 0
      page = 0
    elsif page >= KTutorialPageCount
      page = KTutorialPageCount - 1
    end
    @pageControl.currentPage = page
  end
end
