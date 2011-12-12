package utils {
	import config.Config;

	import flash.display.BitmapData;
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
	}
}
