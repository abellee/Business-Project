package delegates
{
	import controls.SearchConditionItem;

	public interface SearchItemDelegate
	{
		function itemButtonClicked(sp:SearchConditionItem):void;
	}
}