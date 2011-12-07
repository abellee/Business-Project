package data {
	/**
	 * 所有穿着类的数据类
	 * @author Abel
	 */
	public class Dress {
		/**
		 * 图片地址
		 */
		protected var _src : String = "";
		/**
		 * 穿着类型
		 */
		protected var _type : int = 0;

		/**
		 * 创建一个新的Dress实例
		 */
		public function Dress() {
		}

		/**
		 * 清除自身
		 */
		public function dealloc() : void {
			trace("******| Dress |****** received dealloc message!");
			_src = null;
		}

		/**
		 * 获取穿着的图片地址
		 */
		public function get src() : String {
			return _src;
		}

		/**
		 * 设置穿着的图片地址
		 * @param src 图片地址
		 */
		public function set src(src : String) : void {
			if (_src != src) _src = src;
		}

		/**
		 * 获取穿着类型
		 */
		public function get type() : int {
			return _type;
		}

		/**
		 * 设置穿着类型
		 * @param type 穿着类型
		 */
		public function set type(type : int) : void {
			if(_type != type) _type = type;
		}
	}
}
