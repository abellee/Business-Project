package factory {
	import resource.Resource;

	import flash.display.Bitmap;
	import flash.display.BitmapData;

	/**
	 * @author Abel
	 */
	public class StaticAssets {
		/**
		 * 
		 **/
		private var _saveButtonOver : BitmapData;
		/**
		 * 
		 **/
		private var _saveButtonUp : BitmapData;
		/**
		 * 
		 **/
		private var _saveButtonDown : BitmapData;
		/**
		 * 
		 **/
		private var _greenButtonDown : BitmapData;
		/**
		 * 
		 **/
		private var _greenButtonOver : BitmapData;
		/**
		 * 
		 **/
		private var _greenButtonUp : BitmapData;
		/**
		 * 
		 **/
		private var _helpCloseDown : BitmapData;
		/**
		 * 
		 **/
		private var _helpCloseOver : BitmapData;
		/**
		 * 
		 **/
		private var _helpCloseUp : BitmapData;
		/**
		 * 
		 **/
		private var _checkDown : BitmapData;
		/**
		 * 
		 **/
		private var _checkOver : BitmapData;
		/**
		 * 
		 **/
		private var _sliderBar : BitmapData;
		/**
		 * 
		 **/
		private var _sliderTrack : BitmapData;
		/**
		 * 
		 **/
		private var _loginDown : BitmapData;
		/**
		 * 
		 **/
		private var _loginOver : BitmapData;
		/**
		 * 
		 **/
		private var _loginUp : BitmapData;
		/**
		 * 
		 **/
		private var _zoomOutDown : BitmapData;
		/**
		 * 
		 **/
		private var _zoomOutOver : BitmapData;
		/**
		 * 
		 **/
		private var _zoomOutUp : BitmapData;
		/**
		 * 
		 **/
		private var _rectFrame : BitmapData;
		/**
		 * 
		 **/
		private var _backgroundFlipButtonDown : BitmapData;
		/**
		 * 
		 **/
		private var _backgroundFlipButtonOver : BitmapData;
		/**
		 * 
		 **/
		private var _backgroundFlipButtonUp : BitmapData;
		/**
		 * 
		 **/
		private var _arrowDown : BitmapData;
		/**
		 * 
		 **/
		private var _arrowOver : BitmapData;
		/**
		 * 
		 **/
		private var _arrowUp : BitmapData;
		/**
		 * 
		 **/
		private var _scrollBarOver : BitmapData;
		/**
		 * 
		 **/
		private var _closeButtonDown : BitmapData;
		/**
		 * 
		 **/
		private var _closeButtonOver : BitmapData;
		/**
		 * 
		 **/
		private var _closeButtonUp : BitmapData;
		/**
		 * 
		 **/
		private var _scrollBarDown : BitmapData;
		/**
		 * 
		 **/
		private var _scrollBarUp : BitmapData;
		/**
		 * 
		 **/
		private var _bottomDock : BitmapData;
		/**
		 * 
		 **/
		private var _inArrowDown : BitmapData;
		/**
		 * 
		 **/
		private var _inArrowOver : BitmapData;
		/**
		 * 
		 **/
		private var _inArrowUp : BitmapData;
		/**
		 * 
		 **/
		private var _trousersDown : BitmapData;
		/**
		 * 
		 **/
		private var _trousersOver : BitmapData;
		/**
		 * 
		 **/
		private var _trousersUp : BitmapData;
		/**
		 * 
		 **/
		private var _checkUp : BitmapData;
		/**
		 * 
		 **/
		private var _tempPlanTabOver : BitmapData;
		/**
		 * 
		 **/
		private var _tempPlanTabDown : BitmapData;
		/**
		 * 
		 **/
		private var _tempPlanTabUp : BitmapData;
		/**
		 * 
		 **/
		private var _searchButtonUp : BitmapData;
		/**
		 * 
		 **/
		private var _searchButtonDown : BitmapData;
		/**
		 * 
		 **/
		private var _searchButtonOver : BitmapData;
		/**
		 * 
		 **/
		private var _screenShotDown : BitmapData;
		/**
		 * 
		 **/
		private var _screenShotOver : BitmapData;
		/**
		 * 
		 **/
		private var _screenShotUp : BitmapData;
		/**
		 * 
		 **/
		private var _helpButtonDown : BitmapData;
		/**
		 * 
		 **/
		private var _helpButtonOver : BitmapData;
		/**
		 * 
		 **/
		private var _helpButtonUp : BitmapData;
		/**
		 * 
		 **/
		private var _barSkin : BitmapData;
		/**
		 * 
		 **/
		private var _deleteButtonDown : BitmapData;
		/**
		 * 
		 **/
		private var _deleteButtonOver : BitmapData;
		/**
		 * 
		 **/
		private var _deleteButtonUp : BitmapData;
		/**
		 * 
		 **/
		private var _downArrowOver : BitmapData;
		/**
		 * 
		 **/
		private var _upArrowDown : BitmapData;
		/**
		 * 
		 **/
		private var _upArrowOver : BitmapData;
		/**
		 * 
		 **/
		private var _upArrowUp : BitmapData;
		/**
		 * 
		 **/
		private var _downArrowDown : BitmapData;
		/**
		 * 
		 **/
		private var _downArrowUp : BitmapData;
		/**
		 * 
		 **/
		private var _pageButtonDown : BitmapData;
		/**
		 * 
		 **/
		private var _pageButtonOver : BitmapData;
		/**
		 * 
		 **/
		private var _pageButtonUp : BitmapData;
		/**
		 * 
		 **/
		private var _searchOver : BitmapData;
		/**
		 * 
		 **/
		private var _searchDown : BitmapData;
		/**
		 * 
		 **/
		private var _searchUp : BitmapData;
		/**
		 * 
		 **/
		private var _shareFriend : BitmapData;
		/**
		 * 
		 **/
		private var _localStorage : BitmapData;
		/**
		 * 
		 **/
		private var _saveSpace : BitmapData;
		/**
		 * 
		 **/
		private var _zoomInDown : BitmapData;
		/**
		 * 
		 **/
		private var _zoomInOver : BitmapData;
		/**
		 * 
		 **/
		private var _zoomInUp : BitmapData;
		/**
		 * 
		 **/
		private var _searchItem : BitmapData;
		/**
		 * 
		 **/
		private var _frame : BitmapData;
		/**
		 * 
		 **/
		private var _detailButtonDown : BitmapData;
		/**
		 * 
		 **/
		private var _detailButtonOver : BitmapData;
		/**
		 * 
		 **/
		private var _detailButtonUp : BitmapData;
		/**
		 * 
		 **/
		private var _shoeButtonDown : BitmapData;
		/**
		 * 
		 **/
		private var _shoeButtonOver : BitmapData;
		/**
		 * 
		 **/
		private var _shoeButtonUp : BitmapData;
		/**
		 * 
		 **/
		private var _sliderButtonDown : BitmapData;
		/**
		 * 
		 **/
		private var _sliderButtonOver : BitmapData;
		/**
		 * 
		 **/
		private var _sliderButtonUp : BitmapData;
		/**
		 * 
		 **/
		private var _clothesButtonDown : BitmapData;
		/**
		 * 
		 **/
		private var _clothesButtonOver : BitmapData;
		/**
		 * 
		 **/
		private var _clothesButtonUp : BitmapData;
		/**
		 * 
		 **/
		private var _loginInput : BitmapData;
		/**
		 * 
		 **/
		private var _resumeButtonDown : BitmapData;
		/**
		 * 
		 **/
		private var _resumeButtonOver : BitmapData;
		/**
		 * 
		 **/
		private var _resumeButtonUp : BitmapData;
		/**
		 * 
		 **/
		private var _turnArroundButtonDown : BitmapData;
		/**
		 * 
		 **/
		private var _turnArroundButtonOver : BitmapData;
		/**
		 * 
		 **/
		private var _turnArroundButtonUp : BitmapData;
		private var _topLeftButtonUp : BitmapData;
		private var _topLeftButtonOver : BitmapData;
		private var _topLeftButtonDown : BitmapData;
		private var _middleButtonUp : BitmapData;
		private var _middleButtonOver : BitmapData;
		private var _middleButtonDown : BitmapData;

		/**
		 * 
		 **/
		public function saveButtonOver() : BitmapData {
			if (!_saveButtonOver) {
				_saveButtonOver = (new (Resource.SaveButtonOver)() as Bitmap).bitmapData;
			}
			return _saveButtonOver;
		}

		/**
		 * 
		 **/
		public function saveButtonUp() : BitmapData {
			if (!_saveButtonUp) {
				_saveButtonUp = (new (Resource.SaveButtonUp)() as Bitmap).bitmapData;
			}
			return _saveButtonUp;
		}

		/**
		 * 
		 **/
		public function greenButtonDown() : BitmapData {
			if (!_greenButtonDown) {
				_greenButtonDown = (new (Resource.GreenButtonDown)() as Bitmap).bitmapData;
			}
			return _greenButtonDown;
		}

		/**
		 * 
		 **/
		public function greenButtonOver() : BitmapData {
			if (!_greenButtonOver) {
				_greenButtonOver = (new (Resource.GreenButtonOver)() as Bitmap).bitmapData;
			}
			return _greenButtonOver;
		}

		/**
		 * 
		 **/
		public function greenButtonUp() : BitmapData {
			if (!_greenButtonUp) {
				_greenButtonUp = (new (Resource.GreenButtonUp)() as Bitmap).bitmapData;
			}
			return _greenButtonUp;
		}

		/**
		 * 
		 **/
		public function saveButtonDown() : BitmapData {
			if (!_saveButtonDown) {
				_saveButtonDown = (new (Resource.SaveButtonDown)() as Bitmap).bitmapData;
			}
			return _saveButtonDown;
		}

		/**
		 * 
		 **/
		public function helpCloseDown() : BitmapData {
			if (!_helpCloseDown) {
				_helpCloseDown = (new (Resource.HelpCloseDown)() as Bitmap).bitmapData;
			}
			return _helpCloseDown;
		}

		/**
		 * 
		 **/
		public function helpCloseOver() : BitmapData {
			if (!_helpCloseOver) {
				_helpCloseOver = (new (Resource.HelpCloseOver)() as Bitmap).bitmapData;
			}
			return _helpCloseOver;
		}

		/**
		 * 
		 **/
		public function helpCloseUp() : BitmapData {
			if (!_helpCloseUp) {
				_helpCloseUp = (new (Resource.HelpCloseUp)() as Bitmap).bitmapData;
			}
			return _helpCloseUp;
		}

		/**
		 * 
		 **/
		public function checkDown() : BitmapData {
			if (!_checkDown) {
				_checkDown = (new (Resource.CheckDown)() as Bitmap).bitmapData;
			}
			return _checkDown;
		}

		/**
		 * 
		 **/
		public function checkOver() : BitmapData {
			if (!_checkOver) {
				_checkOver = (new (Resource.CheckOver)() as Bitmap).bitmapData;
			}
			return _checkOver;
		}

		/**
		 * 
		 **/
		public function sliderBar() : BitmapData {
			if (!_sliderBar) {
				_sliderBar = (new (Resource.SliderBar)() as Bitmap).bitmapData;
			}
			return _sliderBar;
		}

		/**
		 * 
		 **/
		public function sliderTrack() : BitmapData {
			if (!_sliderTrack) {
				_sliderTrack = (new (Resource.SliderTrack)() as Bitmap).bitmapData;
			}
			return _sliderTrack;
		}

		/**
		 * 
		 **/
		public function loginDown() : BitmapData {
			if (!_loginDown) {
				_loginDown = (new (Resource.LoginDown)() as Bitmap).bitmapData;
			}
			return _loginDown;
		}

		/**
		 * 
		 **/
		public function loginOver() : BitmapData {
			if (!_loginOver) {
				_loginOver = (new (Resource.LoginOver)() as Bitmap).bitmapData;
			}
			return _loginOver;
		}

		/**
		 * 
		 **/
		public function loginUp() : BitmapData {
			if (!_loginUp) {
				_loginUp = (new (Resource.LoginUp)() as Bitmap).bitmapData;
			}
			return _loginUp;
		}

		/**
		 * 
		 **/
		public function zoomOutDown() : BitmapData {
			if (!_zoomOutDown) {
				_zoomOutDown = (new (Resource.ZoomOutDown)() as Bitmap).bitmapData;
			}
			return _zoomOutDown;
		}

		/**
		 * 
		 **/
		public function zoomOutOver() : BitmapData {
			if (!_zoomOutOver) {
				_zoomOutOver = (new (Resource.ZoomOutOver)() as Bitmap).bitmapData;
			}
			return _zoomOutOver;
		}

		/**
		 * 
		 **/
		public function zoomOutUp() : BitmapData {
			if (!_zoomOutUp) {
				_zoomOutUp = (new (Resource.ZoomOutUp)() as Bitmap).bitmapData;
			}
			return _zoomOutUp;
		}

		/**
		 * 
		 **/
		public function rectFrame() : BitmapData {
			if (!_rectFrame) {
				_rectFrame = (new (Resource.RectFrame)() as Bitmap).bitmapData;
			}
			return _rectFrame;
		}

		/**
		 * 
		 **/
		public function backgroundFlipButtonDown() : BitmapData {
			if (!_backgroundFlipButtonDown) {
				_backgroundFlipButtonDown = (new (Resource.BackgroundFlipButtonDown)() as Bitmap).bitmapData;
			}
			return _backgroundFlipButtonDown;
		}

		/**
		 * 
		 **/
		public function backgroundFlipButtonOver() : BitmapData {
			if (!_backgroundFlipButtonOver) {
				_backgroundFlipButtonOver = (new (Resource.BackgroundFlipButtonOver)() as Bitmap).bitmapData;
			}
			return _backgroundFlipButtonOver;
		}

		/**
		 * 
		 **/
		public function backgroundFlipButtonUp() : BitmapData {
			if (!_backgroundFlipButtonUp) {
				_backgroundFlipButtonUp = (new (Resource.BackgroundFlipButtonUp)() as Bitmap).bitmapData;
			}
			return _backgroundFlipButtonUp;
		}

		/**
		 * 
		 **/
		public function arrowDown() : BitmapData {
			if (!_arrowDown) {
				_arrowDown = (new (Resource.ArrowDown)() as Bitmap).bitmapData;
			}
			return _arrowDown;
		}

		/**
		 * 
		 **/
		public function arrowOver() : BitmapData {
			if (!_arrowOver) {
				_arrowOver = (new (Resource.ArrowOver)() as Bitmap).bitmapData;
			}
			return _arrowOver;
		}

		/**
		 * 
		 **/
		public function arrowUp() : BitmapData {
			if (!_arrowUp) {
				_arrowUp = (new (Resource.ArrowUp)() as Bitmap).bitmapData;
			}
			return _arrowUp;
		}

		/**
		 * 
		 **/
		public function scrollBarOver() : BitmapData {
			if (!_scrollBarOver) {
				_scrollBarOver = (new (Resource.ScrollBarOver)() as Bitmap).bitmapData;
			}
			return _scrollBarOver;
		}

		/**
		 * 
		 **/
		public function closeButtonDown() : BitmapData {
			if (!_closeButtonDown) {
				_closeButtonDown = (new (Resource.CloseButtonDown)() as Bitmap).bitmapData;
			}
			return _closeButtonDown;
		}

		/**
		 * 
		 **/
		public function closeButtonOver() : BitmapData {
			if (!_closeButtonOver) {
				_closeButtonOver = (new (Resource.CloseButtonOver)() as Bitmap).bitmapData;
			}
			return _closeButtonOver;
		}

		/**
		 * 
		 **/
		public function closeButtonUp() : BitmapData {
			if (!_closeButtonUp) {
				_closeButtonUp = (new (Resource.CloseButtonUp)() as Bitmap).bitmapData;
			}
			return _closeButtonUp;
		}

		/**
		 * 
		 **/
		public function scrollBarDown() : BitmapData {
			if (!_scrollBarDown) {
				_scrollBarDown = (new (Resource.ScrollBarDown)() as Bitmap).bitmapData;
			}
			return _scrollBarDown;
		}

		/**
		 * 
		 **/
		public function scrollBarUp() : BitmapData {
			if (!_scrollBarUp) {
				_scrollBarUp = (new (Resource.ScrollBarUp)() as Bitmap).bitmapData;
			}
			return _scrollBarUp;
		}

		/**
		 * 
		 **/
		public function bottomDock() : BitmapData {
			if (!_bottomDock) {
				_bottomDock = (new (Resource.BottomDock)() as Bitmap).bitmapData;
			}
			return _bottomDock;
		}

		/**
		 * 
		 **/
		public function inArrowDown() : BitmapData {
			if (!_inArrowDown) {
				_inArrowDown = (new (Resource.InArrowDown)() as Bitmap).bitmapData;
			}
			return _inArrowDown;
		}

		/**
		 * 
		 **/
		public function inArrowOver() : BitmapData {
			if (!_inArrowOver) {
				_inArrowOver = (new (Resource.InArrowOver)() as Bitmap).bitmapData;
			}
			return _inArrowOver;
		}

		/**
		 * 
		 **/
		public function inArrowUp() : BitmapData {
			if (!_inArrowUp) {
				_inArrowUp = (new (Resource.InArrowUp)() as Bitmap).bitmapData;
			}
			return _inArrowUp;
		}

		/**
		 * 
		 **/
		public function trousersDown() : BitmapData {
			if (!_trousersDown) {
				_trousersDown = (new (Resource.TrousersDown)() as Bitmap).bitmapData;
			}
			return _trousersDown;
		}

		/**
		 * 
		 **/
		public function trousersOver() : BitmapData {
			if (!_trousersOver) {
				_trousersOver = (new (Resource.TrousersOver)() as Bitmap).bitmapData;
			}
			return _trousersOver;
		}

		/**
		 * 
		 **/
		public function trousersUp() : BitmapData {
			if (!_trousersUp) {
				_trousersUp = (new (Resource.TrousersUp)() as Bitmap).bitmapData;
			}
			return _trousersUp;
		}

		/**
		 * 
		 **/
		public function checkUp() : BitmapData {
			if (!_checkUp) {
				_checkUp = (new (Resource.CheckUp)() as Bitmap).bitmapData;
			}
			return _checkUp;
		}

		/**
		 * 
		 **/
		public function tempPlanTabOver() : BitmapData {
			if (!_tempPlanTabOver) {
				_tempPlanTabOver = (new (Resource.TempPlanTabOver)() as Bitmap).bitmapData;
			}
			return _tempPlanTabOver;
		}

		/**
		 * 
		 **/
		public function tempPlanTabDown() : BitmapData {
			if (!_tempPlanTabDown) {
				_tempPlanTabDown = (new (Resource.TempPlanTabDown)() as Bitmap).bitmapData;
			}
			return _tempPlanTabDown;
		}

		/**
		 * 
		 **/
		public function tempPlanTabUp() : BitmapData {
			if (!_tempPlanTabUp) {
				_tempPlanTabUp = (new (Resource.TempPlanTabUp)() as Bitmap).bitmapData;
			}
			return _tempPlanTabUp;
		}

		/**
		 * 
		 **/
		public function searchButtonUp() : BitmapData {
			if (!_searchButtonUp) {
				_searchButtonUp = (new (Resource.SearchButtonUp)() as Bitmap).bitmapData;
			}
			return _searchButtonUp;
		}

		/**
		 * 
		 **/
		public function searchButtonDown() : BitmapData {
			if (!_searchButtonDown) {
				_searchButtonDown = (new (Resource.SearchButtonDown)() as Bitmap).bitmapData;
			}
			return _searchButtonDown;
		}

		/**
		 * 
		 **/
		public function searchButtonOver() : BitmapData {
			if (!_searchButtonOver) {
				_searchButtonOver = (new (Resource.SearchButtonOver)() as Bitmap).bitmapData;
			}
			return _searchButtonOver;
		}

		/**
		 * 
		 **/
		public function screenShotDown() : BitmapData {
			if (!_screenShotDown) {
				_screenShotDown = (new (Resource.ScreenShotDown)() as Bitmap).bitmapData;
			}
			return _screenShotDown;
		}

		/**
		 * 
		 **/
		public function screenShotOver() : BitmapData {
			if (!_screenShotOver) {
				_screenShotOver = (new (Resource.ScreenShotOver)() as Bitmap).bitmapData;
			}
			return _screenShotOver;
		}

		/**
		 * 
		 **/
		public function screenShotUp() : BitmapData {
			if (!_screenShotUp) {
				_screenShotUp = (new (Resource.ScreenShotUp)() as Bitmap).bitmapData;
			}
			return _screenShotUp;
		}

		/**
		 * 
		 **/
		public function helpButtonDown() : BitmapData {
			if (!_helpButtonDown) {
				_helpButtonDown = (new (Resource.HelpButtonDown)() as Bitmap).bitmapData;
			}
			return _helpButtonDown;
		}

		/**
		 * 
		 **/
		public function helpButtonOver() : BitmapData {
			if (!_helpButtonOver) {
				_helpButtonOver = (new (Resource.HelpButtonOver)() as Bitmap).bitmapData;
			}
			return _helpButtonOver;
		}

		/**
		 * 
		 **/
		public function helpButtonUp() : BitmapData {
			if (!_helpButtonUp) {
				_helpButtonUp = (new (Resource.HelpButtonUp)() as Bitmap).bitmapData;
			}
			return _helpButtonUp;
		}

		/**
		 * 
		 **/
		public function barSkin() : BitmapData {
			if (!_barSkin) {
				_barSkin = (new (Resource.BarSkin)() as Bitmap).bitmapData;
			}
			return _barSkin;
		}

		/**
		 * 
		 **/
		public function deleteButtonDown() : BitmapData {
			if (!_deleteButtonDown) {
				_deleteButtonDown = (new (Resource.DeleteButtonDown)() as Bitmap).bitmapData;
			}
			return _deleteButtonDown;
		}

		/**
		 * 
		 **/
		public function deleteButtonOver() : BitmapData {
			if (!_deleteButtonOver) {
				_deleteButtonOver = (new (Resource.DeleteButtonOver)() as Bitmap).bitmapData;
			}
			return _deleteButtonOver;
		}

		/**
		 * 
		 **/
		public function deleteButtonUp() : BitmapData {
			if (!_deleteButtonUp) {
				_deleteButtonUp = (new (Resource.DeleteButtonUp)() as Bitmap).bitmapData;
			}
			return _deleteButtonUp;
		}

		/**
		 * 
		 **/
		public function downArrowOver() : BitmapData {
			if (!_downArrowOver) {
				_downArrowOver = (new (Resource.DownArrowOver)() as Bitmap).bitmapData;
			}
			return _downArrowOver;
		}

		/**
		 * 
		 **/
		public function upArrowDown() : BitmapData {
			if (!_upArrowDown) {
				_upArrowDown = (new (Resource.UpArrownDown)() as Bitmap).bitmapData;
			}
			return _upArrowDown;
		}

		/**
		 * 
		 **/
		public function upArrowOver() : BitmapData {
			if (!_upArrowOver) {
				_upArrowOver = (new (Resource.UpArrowOver)() as Bitmap).bitmapData;
			}
			return _upArrowOver;
		}

		/**
		 * 
		 **/
		public function upArrowUp() : BitmapData {
			if (!_upArrowUp) {
				_upArrowUp = (new (Resource.UpArrownUp)() as Bitmap).bitmapData;
			}
			return _upArrowUp;
		}

		/**
		 * 
		 **/
		public function downArrowDown() : BitmapData {
			if (!_downArrowDown) {
				_downArrowDown = (new (Resource.DownArrowDown)() as Bitmap).bitmapData;
			}
			return _downArrowDown;
		}

		/**
		 * 
		 **/
		public function downArrowUp() : BitmapData {
			if (!_downArrowUp) {
				_downArrowUp = (new (Resource.DownArrowUp)() as Bitmap).bitmapData;
			}
			return _downArrowUp;
		}

		/**
		 * 
		 **/
		public function pageButtonDown() : BitmapData {
			if (!_pageButtonDown) {
				_pageButtonDown = (new (Resource.PageButtonDown)() as Bitmap).bitmapData;
			}
			return _pageButtonDown;
		}

		/**
		 * 
		 **/
		public function pageButtonOver() : BitmapData {
			if (!_pageButtonOver) {
				_pageButtonOver = (new (Resource.PageButtonOver)() as Bitmap).bitmapData;
			}
			return _pageButtonOver;
		}

		/**
		 * 
		 **/
		public function pageButtonUp() : BitmapData {
			if (!_pageButtonUp) {
				_pageButtonUp = (new (Resource.PageButtonUp)() as Bitmap).bitmapData;
			}
			return _pageButtonUp;
		}

		/**
		 * 
		 **/
		public function searchOver() : BitmapData {
			if (!_searchOver) {
				_searchOver = (new (Resource.SearchOver)() as Bitmap).bitmapData;
			}
			return _searchOver;
		}

		/**
		 * 
		 **/
		public function searchDown() : BitmapData {
			if (!_searchDown) {
				_searchDown = (new (Resource.SearchDown)() as Bitmap).bitmapData;
			}
			return _searchDown;
		}

		public function searchUp() : BitmapData {
			if (!_searchUp) {
				_searchUp = (new (Resource.SearchUp) as Bitmap).bitmapData;
			}
			return _searchUp;
		}

		/**
		 * 
		 **/
		public function shareFriend() : BitmapData {
			if (!_shareFriend) {
				_shareFriend = (new (Resource.ShareFriend)() as Bitmap).bitmapData;
			}
			return _shareFriend;
		}

		/**
		 * 
		 **/
		public function localStorage() : BitmapData {
			if (!_localStorage) {
				_localStorage = (new (Resource.LocalStorage)() as Bitmap).bitmapData;
			}
			return _localStorage;
		}

		/**
		 * 
		 **/
		public function saveSpace() : BitmapData {
			if (!_saveSpace) {
				_saveSpace = (new (Resource.SaveSpace)() as Bitmap).bitmapData;
			}
			return _saveSpace;
		}

		/**
		 * 
		 **/
		public function zoomInDown() : BitmapData {
			if (!_zoomInDown) {
				_zoomInDown = (new (Resource.ZoomInDown)() as Bitmap).bitmapData;
			}
			return _zoomInDown;
		}

		/**
		 * 
		 **/
		public function zoomInOver() : BitmapData {
			if (!_zoomInOver) {
				_zoomInOver = (new (Resource.ZoomInOver)() as Bitmap).bitmapData;
			}
			return _zoomInOver;
		}

		/**
		 * 
		 **/
		public function zoomInUp() : BitmapData {
			if (!_zoomInUp) {
				_zoomInUp = (new (Resource.ZoomInUp)() as Bitmap).bitmapData;
			}
			return _zoomInUp;
		}

		/**
		 * 
		 **/
		public function searchItem() : BitmapData {
			if (!_searchItem) {
				_searchItem = (new (Resource.SearchItem)() as Bitmap).bitmapData;
			}
			return _searchItem;
		}

		/**
		 * 
		 **/
		public function frame() : BitmapData {
			if (!_frame) {
				_frame = (new (Resource.Frame)() as Bitmap).bitmapData;
			}
			return _frame;
		}

		/**
		 * 
		 **/
		public function detailButtonDown() : BitmapData {
			if (!_detailButtonDown) {
				_detailButtonDown = (new (Resource.DetailButtonDown)() as Bitmap).bitmapData;
			}
			return _detailButtonDown;
		}

		/**
		 * 
		 **/
		public function detailButtonOver() : BitmapData {
			if (!_detailButtonOver) {
				_detailButtonOver = (new (Resource.DetailButtonOver)() as Bitmap).bitmapData;
			}
			return _detailButtonOver;
		}

		/**
		 * 
		 **/
		public function detailButtonUp() : BitmapData {
			if (!_detailButtonUp) {
				_detailButtonUp = (new (Resource.DetailButtonUp)() as Bitmap).bitmapData;
			}
			return _detailButtonUp;
		}

		/**
		 * 
		 **/
		public function shoeButtonDown() : BitmapData {
			if (!_shoeButtonDown) {
				_shoeButtonDown = (new (Resource.ShoeButtonDown)() as Bitmap).bitmapData;
			}
			return _shoeButtonDown;
		}

		/**
		 * 
		 **/
		public function shoeButtonOver() : BitmapData {
			if (!_shoeButtonOver) {
				_shoeButtonOver = (new (Resource.ShoeButtonOver)() as Bitmap).bitmapData;
			}
			return _shoeButtonOver;
		}

		/**
		 * 
		 **/
		public function shoeButtonUp() : BitmapData {
			if (!_shoeButtonUp) {
				_shoeButtonUp = (new (Resource.ShoeButtonUp)() as Bitmap).bitmapData;
			}
			return _shoeButtonUp;
		}

		/**
		 * 
		 **/
		public function sliderButtonDown() : BitmapData {
			if (!_sliderButtonDown) {
				_sliderButtonDown = (new (Resource.SliderButtonDown)() as Bitmap).bitmapData;
			}
			return _sliderButtonDown;
		}

		/**
		 * 
		 **/
		public function sliderButtonOver() : BitmapData {
			if (!_sliderButtonOver) {
				_sliderButtonOver = (new (Resource.SliderButtonOver)() as Bitmap).bitmapData;
			}
			return _sliderButtonOver;
		}

		/**
		 * 
		 **/
		public function sliderButtonUp() : BitmapData {
			if (!_sliderButtonUp) {
				_sliderButtonUp = (new (Resource.SliderButtonUp)() as Bitmap).bitmapData;
			}
			return _sliderButtonUp;
		}

		/**
		 * 
		 **/
		public function clothesButtonDown() : BitmapData {
			if (!_clothesButtonDown) {
				_clothesButtonDown = (new (Resource.ClothesButtonDown)() as Bitmap).bitmapData;
			}
			return _clothesButtonDown;
		}

		/**
		 * 
		 **/
		public function clothesButtonOver() : BitmapData {
			if (!_clothesButtonOver) {
				_clothesButtonOver = (new (Resource.ClothesButtonOver)() as Bitmap).bitmapData;
			}
			return _clothesButtonOver;
		}

		/**
		 * 
		 **/
		public function clothesButtonUp() : BitmapData {
			if (!_clothesButtonUp) {
				_clothesButtonUp = (new (Resource.ClothesButtonUp)() as Bitmap).bitmapData;
			}
			return _clothesButtonUp;
		}

		/**
		 * 
		 **/
		public function loginInput() : BitmapData {
			if (!_loginInput) {
				_loginInput = (new (Resource.LoginInput)() as Bitmap).bitmapData;
			}
			return _loginInput;
		}

		/**
		 * 
		 **/
		public function resumeButtonDown() : BitmapData {
			if (!_resumeButtonDown) {
				_resumeButtonDown = (new (Resource.ResumeButtonDown)() as Bitmap).bitmapData;
			}
			return _resumeButtonDown;
		}

		/**
		 * 
		 **/
		public function resumeButtonOver() : BitmapData {
			if (!_resumeButtonOver) {
				_resumeButtonOver = (new (Resource.ResumeButtonOver)() as Bitmap).bitmapData;
			}
			return _resumeButtonOver;
		}

		/**
		 * 
		 **/
		public function resumeButtonUp() : BitmapData {
			if (!_resumeButtonUp) {
				_resumeButtonUp = (new (Resource.ResumeButtonUp)() as Bitmap).bitmapData;
			}
			return _resumeButtonUp;
		}

		/**
		 * 
		 **/
		public function turnArroundButtonDown() : BitmapData {
			if (!_turnArroundButtonDown) {
				_turnArroundButtonDown = (new (Resource.TurnArroundButtonDown)() as Bitmap).bitmapData;
			}
			return _turnArroundButtonDown;
		}

		/**
		 * 
		 **/
		public function turnArroundButtonOver() : BitmapData {
			if (!_turnArroundButtonOver) {
				_turnArroundButtonOver = (new (Resource.TurnArroundButtonOver)() as Bitmap).bitmapData;
			}
			return _turnArroundButtonOver;
		}

		/**
		 * 
		 **/
		public function turnArroundButtonUp() : BitmapData {
			if (!_turnArroundButtonUp) {
				_turnArroundButtonUp = (new (Resource.TurnArroundButtonUp)() as Bitmap).bitmapData;
			}
			return _turnArroundButtonUp;
		}

		public function topLeftButtonUp() : BitmapData {
			if (!_topLeftButtonUp) {
				_topLeftButtonUp = (new (Resource.LeftTopButtonUp)() as Bitmap).bitmapData;
			}
			return _topLeftButtonUp;
		}

		public function topLeftButtonOver() : BitmapData {
			if (!_topLeftButtonOver) {
				_topLeftButtonOver = (new (Resource.LeftTopButtonOver)() as Bitmap).bitmapData;
			}
			return _topLeftButtonOver;
		}

		public function topLeftButtonDown() : BitmapData {
			if (!_topLeftButtonDown) {
				_topLeftButtonDown = (new (Resource.LeftTopButtonDown)() as Bitmap).bitmapData;
			}
			return _topLeftButtonDown;
		}

		public function middleButtonUp() : BitmapData {
			if (!_middleButtonUp) {
				_middleButtonUp = (new (Resource.MiddleButtonUp)() as Bitmap).bitmapData;
			}
			return _middleButtonUp;
		}

		public function middleButtonOver() : BitmapData {
			if (!_middleButtonOver) {
				_middleButtonOver = (new (Resource.MiddleButtonOver)() as Bitmap).bitmapData;
			}
			return _middleButtonOver;
		}

		public function middleButtonDown() : BitmapData {
			if (!_middleButtonDown) {
				_middleButtonDown = (new (Resource.MiddleButtonDown)() as Bitmap).bitmapData;
			}
			return _middleButtonDown;
		}
	}
}
