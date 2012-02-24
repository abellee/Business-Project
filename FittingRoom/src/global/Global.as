package global {
	import controls.ProccessingView;
	
	import data.Sex;
	
	import factory.StaticAssets;
	
	import flash.net.NetConnection;

	/**
	 * @author Abel
	 */
	public class Global {
		public static var staticAssets : StaticAssets;
		public static var fontStyle : FontFormat;
		public static var proccessingView : ProccessingView = new ProccessingView();
		public static var connection : NetConnection = new NetConnection();
		
		public static var curSex : int = Sex.FEMALE;
	}
}
