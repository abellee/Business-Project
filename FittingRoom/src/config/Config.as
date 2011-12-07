package config {
	import flash.errors.IllegalOperationError;

	/**
	 * 配置类
	 * 界面所有配置都在此配置
	 * @author Abel
	 */
	public class Config {
		/**
		 * 实例
		 */
		private static var _instance : Config = new Config();
		/**
		 * 背景图片地址
		 */
		public var backgroundURL : String = "";

		/**
		 * 单例模式，使用getter"instance"取得实例。
		 */
		public function Config() {
			if (Object(this).constructor == Config) {
				throw new IllegalOperationError("You can't instance this class directly!");
				return;
			}
		}

		/**
		 * getter
		 * 获取类实例
		 */
		public static function get instance() : Config {
			return _instance;
		}
	}
}
