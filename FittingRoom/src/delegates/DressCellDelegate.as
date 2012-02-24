package delegates
{
	import controls.DressCell;

	public interface DressCellDelegate
	{
		function cellClicked(cell:DressCell):void;
	}
}