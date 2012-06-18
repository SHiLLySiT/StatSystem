package statsystem.inventory 
{
	/**
	 * Holds a stack of items.
	 * @author alex larioza
	 */
	public class ItemStack 
	{
		private var _item:Item;
		private var _count:int;
		
		/**
		 * Creates a new ItemStack.
		 * @param	item	The item the stack should hold
		 * @param	count	The number of items
		 */
		public function ItemStack(item:Item, count:int = 1) 
		{
			_item = item;
			_count = count;
		}
		
		/**
		 * Adds the specified amount of the item to the stack, but will not exceed the max stack of the item. The excess amount (if any) is returned.
		 * @param	amount	The amount to add
		 * @return	The excess amount e.g., the amount of the item that did not fit in this stack.
		 */
		public function add(amount:uint):int
		{
			var excess:uint = 0;
			if (_count + amount <= _item.stack  || _item.stack == -1) {
				_count += amount;
			} else {
				_count = _item.stack;
				excess = amount - (_item.stack - _count);
			}
			return excess;
		}
		
		/**
		 * Sets the amount of the item in the stack.
		 * @param	amount	The amount
		 */
		public function setAmount(amount:uint):void
		{
			_count = amount;
		}
		
		/**
		 * Removes the specified amount from the stack. If the amount to be removed is greater than the actual amount, that number is returned.
		 * @param	amount	The amount to remove
		 * @return	The remaining amount to be removed e.g., amount - actual amount
		 */
		public function remove(amount:uint):int
		{
			var excess:uint = 0;
			if (_count - amount > 0) {
				_count -= amount;
			} else {
				_count = 0;
				excess = amount - _count;
			}
			return excess;
		}
		
		/**
		 * Gets the item this stack is holding.
		 */
		public function get item():Item { return _item; }
		/**
		 * Gets the amount of the item this stack is holding.
		 */
		public function get count():uint { return _count; }
	}

}