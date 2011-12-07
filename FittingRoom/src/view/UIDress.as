package view {
	import flash.display.Shape;
	import flash.display.Bitmap;

	import com.kge.core.UIView;

	/**
	 * 所有身上穿着打扮视图的基类
	 * @author Abel
	 */
	public class UIDress extends UIView {
		/**
		 * 视图中的图片
		 */
		protected var _bitmap : Bitmap;
		/**
		 * 视图的背景
		 */
		protected var _background : Shape;
		/**
		 * 视图背景颜色
		 */
		protected var _backgroundColor : Number = 0xFFFFFF;
		/**
		 * 视图的宽度
		 */
		protected var _viewWidth : int = 0;
		/**
		 * 视图的高度
		 */
		protected var _viewHeight : int = 0;
		/**
		 * 四周空白
		 */
		protected var _padding : int = 5;

		/**
		 * 创建一个新的UIDress实例。
		 */
		public function UIDress(w : int, h : int) {
			super();

			_viewWidth = w;
			_viewHeight = h;

			drawBackground();
		}

		/**
		 * 重新绘制视图
		 */
		public function needUpdateDisplay() : void {
			draw();
		}

		/**
		 * 覆写doChanged()
		 */
		override protected function doChange() : void {
			draw();
			super.doChange();
		}

		/**
		 * 绘制视图
		 */
		protected function draw() : void {
			trace("******| " + this + " |****** received draw message!");
			drawBackground();
			if (_bitmap) addChildAt(_bitmap, 1);
		}

		/**
		 * 绘制背景
		 */
		protected function drawBackground() : void {
			if (!_background) _background = new Shape();
			_background.graphics.clear();
			_background.graphics.beginFill(_backgroundColor);
			_background.graphics.drawRect(0, 0, _viewWidth + _padding * 2, _viewHeight + _padding * 2);
			_background.graphics.endFill();
			addChildAt(_background, 0);
		}

		/**
		 * 获取视图宽度
		 */
		public function get viewWidth() : int {
			return _viewWidth;
		}

		/**
		 * 设置视图的宽度
		 */
		public function set viewWidth(viewWidth : int) : void {
			if (_viewWidth != viewWidth) {
				_viewWidth = viewWidth;
				hasChanged();
			}
		}

		/**
		 * 获取视图高度
		 */
		public function get viewHeight() : int {
			return _viewHeight;
		}

		/**
		 * 设置视图高度
		 */
		public function set viewHeight(viewHeight : int) : void {
			if (_viewHeight != viewHeight) {
				_viewHeight = viewHeight;
				hasChanged();
			}
		}

		/**
		 * 获取背景颜色
		 */
		public function get backgroundColor() : Number {
			return _backgroundColor;
		}

		/**
		 * 设置背景颜色
		 */
		public function set backgroundColor(backgroundColor : Number) : void {
			if (_backgroundColor != backgroundColor) {
				_backgroundColor = backgroundColor;
				hasChanged();
			}
		}

		/**
		 * 获取视图中的图片
		 */
		public function get bitmap() : Bitmap {
			return _bitmap;
		}

		/**
		 * 设置视图中的图片
		 */
		public function set bitmap(bitmap : Bitmap) : void {
			if (_bitmap) {
				if (_bitmap != bitmap && _bitmap.bitmapData != bitmap.bitmapData) {
					_bitmap.bitmapData.dispose();
				} else {
					return;
				}
			}
			_bitmap = bitmap;
			addChild(_bitmap);
		}

		/**
		 * 自我清除
		 */
		override public function dealloc() : void {
			super.dealloc();

			removeChild(_bitmap);
			removeChild(_background);
			_bitmap.bitmapData.dispose();
			_bitmap = null;
			_background.graphics.clear();
			_background = null;
		}

		/**
		 * 获取视图四周填充
		 */
		public function get padding() : int {
			return _padding;
		}

		/**
		 * 设置视图四周填充
		 * @param padding 四周的填充值
		 */
		public function set padding(padding : int) : void {
			if (_padding != padding) {
				_padding = padding;
				hasChanged();
			}
		}
	}
}
