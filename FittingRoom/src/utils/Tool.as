package utils {
	import config.Config;
	
	import data.DressSize;
	
	import flash.display.BitmapData;
	import flash.filters.BitmapFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;

	/**
	 * 全局工具类
	 * @author Abel
	 */
	public class Tool {
		/**
		 * 水平反向位图
		 */
		public static function bitmapDataReverseX(bitmapData : BitmapData) : BitmapData {
			var matrix : Matrix = new Matrix();
			matrix.translate(- bitmapData.width, 0);
			matrix.scale(-1, 1);

			var bp : BitmapData = new BitmapData(bitmapData.width, bitmapData.height, true, 0x00);
			bp.draw(bitmapData, matrix, null, null, null, true);
			return bp;
		}

		/**
		 * 垂直反向位图
		 */
		public static function bitmapDataReverseY(bitmapData : BitmapData) : BitmapData {
			var matrix : Matrix = new Matrix();
			matrix.translate(0, - bitmapData.height);
			matrix.scale(1, -1);

			var bp : BitmapData = new BitmapData(bitmapData.width, bitmapData.height, true, 0x00);
			bp.draw(bitmapData, matrix, null, null, null, true);
			return bp;
		}
		
		/**
		 * 获取尺寸S M L
		 */
		public static function getDressSize(value : Number):String{
			return DressSize.M;
		}
		
		public static function getBitmapFilter():BitmapFilter {
			var color:Number = 0x000000;
			var alpha:Number = 0.5;
			var blurX:Number = 10;
			var blurY:Number = 10;
			var strength:Number = 1;
			var inner:Boolean = false;
			var knockout:Boolean = true;
			var quality:Number = BitmapFilterQuality.HIGH;
			
			return new GlowFilter(color,
				alpha,
				blurX,
				blurY,
				strength,
				quality,
				inner,
				knockout);
		}
	}
}
