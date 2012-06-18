package statsystem.inventory  
{
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import statsystem.Stat;
	/**
	 * Reads a database of items from an XML file into memory, providing easy reference to items. This class is OPTIONAL and not required to use the inventory features.
	 * @author alex larioza
	 */
	public class Database 
	{
		private var _database:Dictionary;
		
		/**
		 * Creates a new item database.
		 * @param	database	The XML file to load the database from
		 */
		public function Database(database:Class) 
		{
			_database = new Dictionary();
			
			var bytes:ByteArray = new database;
			var xml:XML = XML(bytes.readUTFBytes(bytes.length));
			var dataList:XMLList;
			var dataElement:XML;
			
			dataList = xml.item;
			for each (dataElement in dataList) {
				var item:Item = new Item(dataElement.@name, dataElement.@stack);
				
				for each (var stat:XML in dataElement.stat) {
					item.stats.addStat(new Stat(stat.@name, stat.@value, stat.@maxValue));
				}
				
				_database[item.name] = item;
			}
		}
		
		/**
		 * Returns the item with the given name, if any.
		 * @param	name	The name of the item to get
		 * @return	The item object with the specified name
		 */
		public function getItem(name:String):Item
		{
			return _database[name];
		}
		
	}

}