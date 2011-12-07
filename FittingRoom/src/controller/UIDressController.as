package controller {
	import flash.events.MouseEvent;

	import data.Dress;

	import delegates.IUIDressControllerDelegate;

	import view.UIDress;

	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.net.URLRequest;

	/**
	 * 所有穿着类的控制器
	 * @author Abel
	 */
	public class UIDressController {
		/**
		 * 视图类
		 */
		protected var _view : UIDress;
		/**
		 * 数据类
		 */
		protected var _data : Dress;
		/**
		 * 加载图片的loader
		 */
		protected var loader : Loader;
		/**
		 * 委托
		 */
		public var delegate : IUIDressControllerDelegate;

		/**
		 * 创建一个新的UIDressController实例。
		 */
		public function UIDressController() {
			view = new UIDress(183, 81);
		}

		/**
		 * 初始化数据
		 */
		public function initData(data : Dress) : void {
			if (_data) {
				if (_data != data)
					_data.dealloc();
				else
					return;
			}
			_data = data;
			loadImage();
		}

		/**
		 * 加载视图图片
		 * @param src 图片地址
		 */
		protected function loadImage() : void {
			var src : String = _data.src;
			if (!src || src == "") {
				throw new IllegalOperationError("src is not specify!");
			}
			if (!loader) loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadImage_completeHandler);
			loader.load(new URLRequest(src));
		}

		/**
		 * 视图图片加载完成
		 * @param event Event.COMPLETE
		 */
		protected function loadImage_completeHandler(event : Event) : void {
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, loadImage_completeHandler);
			_view.bitmap = loader.content as Bitmap;
			loader = null;
		}

		/**
		 * 取得当前视图
		 */
		public function get view() : UIDress {
			return _view;
		}

		/**
		 * 设置当前视图
		 * @param view 穿着视图
		 */
		public function set view(view : UIDress) : void {
			if (_view) {
				if (_view != view) {
					_view.dealloc();
				} else {
					return;
				}
			}
			_view = view;
			_view.addEventListener(MouseEvent.CLICK, view_mouseClickHandler);
		}

		/**
		 * 视图鼠标点击
		 */
		protected function view_mouseClickHandler(event : MouseEvent) : void {
			if (delegate) delegate.dressClicked();
		}

		/**
		 * [只读]设置当前数据模型
		 * @return 穿着的数据
		 */
		public function get data() : Dress {
			return _data;
		}

		/**
		 * 清除自身
		 */
		public function dealloc() : void {
			if (_view) _view.dealloc();
			_view = null;
			if (_data) _data.dealloc();
			_data = null;
			if (loader) {
				try {
					loader.close();
				} catch(e : Error) {
				}
				loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, loadImage_completeHandler);
			}
			loader = null;
		}
	}
}
