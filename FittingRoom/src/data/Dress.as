package data {
	import flash.display.Bitmap;

	/**
	 * 所有穿着类的数据类
	 * @author Abel
	 */
	public class Dress {
		protected var _id : int = 0;
		protected var _dressName : String;
		protected var _price:uint = 0;
		protected var _smallImage : String = "";
		protected var _middleImage : String = "";
		protected var _bigImage : String = "";
		/**
		 * 穿着类型
		 */
		protected var _type : int = 0;
		protected var _rejectType : int = -1;
		protected var _sex : int = 0;
		protected var _numSize : Number = 44;
		protected var _stringSize : String = "S";
		protected var _dirBitmap:Object = {};
		protected var _colorList:Array;

		/**
		 * 创建一个新的Dress实例
		 */
		public function Dress() {
		}

		public function get colorList():Array
		{
			return _colorList;
		}

		public function set colorList(value:Array):void
		{
			_colorList = value;
		}

		public function get price():uint
		{
			return _price;
		}

		public function set price(value:uint):void
		{
			_price = value;
		}

		public function get dressName():String
		{
			return _dressName;
		}

		public function set dressName(value:String):void
		{
			_dressName = value;
		}

		public function get id():int
		{
			return _id;
		}

		public function set id(value:int):void
		{
			_id = value;
		}

		public function getBitmapByDir(str:String):Bitmap
		{
			return _dirBitmap[str];
		}

		/**
		 * 大图地址
		 */
		public function get bigImage():String
		{
			return _bigImage;
		}

		/**
		 * @private
		 */
		public function set bigImage(value:String):void
		{
			_bigImage = value;
		}

		/**
		 * 中图地址
		 */
		public function get middleImage():String
		{
			return _middleImage;
		}

		/**
		 * @private
		 */
		public function set middleImage(value:String):void
		{
			_middleImage = value;
		}

		/**
		 * 小图地址
		 */
		public function get smallImage():String
		{
			return _smallImage;
		}

		/**
		 * @private
		 */
		public function set smallImage(value:String):void
		{
			_smallImage = value;
		}

		public function get rejectType():int
		{
			return _rejectType;
		}

		public function set rejectType(value:int):void
		{
			_rejectType = value;
		}

		public function get stringSize():String
		{
			return _stringSize;
		}

		public function set stringSize(value:String):void
		{
			_stringSize = value;
		}

		public function get numSize():Number
		{
			return _numSize;
		}

		public function set numSize(value:Number):void
		{
			_numSize = value;
		}

		public function get sex():int
		{
			return _sex;
		}

		public function set sex(value:int):void
		{
			_sex = value;
		}
		
		/**
		 * 清除自身
		 */
		public function dealloc() : void {
			trace("******| Dress |****** received dealloc message!");
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
