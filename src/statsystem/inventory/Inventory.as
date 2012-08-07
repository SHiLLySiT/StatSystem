package statsystem.inventory  
{
	/**
	 * Acts as a container of items.
	 * @author alex larioza
	 */
	public class Inventory 
	{
		private var _items:Vector.<ItemStack>
		private var _size:int;
		private var _type:int;
		
		/**
		 * Creates a new item inventory.
		 * @param	size	The max size of the inventory
		 */
		public function Inventory(size:uint) 
		{
			_size = size;
			_items = new Vector.<ItemStack>(size);
		}
		
		/**
		 * Adds an item to the inventory.
		 * @param	item	The item to add
		 * @param	amount	The amount of the item to add
		 * @return	The excess amount i.e., the amount of the item that did not fit in this stack.
		 */
		public function addItem(item:Item, amount:uint):int
		{
			for (var i:uint = 0; i < _items.length; i++) { // for the length of the inventory
				if (_items[i]) { // if there is something in the slot...
					if (_items[i].item.name == item.name) { // ...and its the same item
						amount = _items[i].add(amount); // add item to the stack and set amount to any excess
					}
				} else { // if there is no item...
					if (amount > item.stack) { // ...if amount to add is great than the max stack...
						_items[i] = new ItemStack(item, item.stack); // ...add a full stack
						amount -= item.stack; // and subtract a full stack from the amount
					} else { // else, just add a full stack
						_items[i] = new ItemStack(item, amount); 
						amount = 0;
					} 
				}
				if (amount <= 0) { return 0; } // if not more items, quit
			}
			// if there are still items, return amount
			if (amount > 0) { return amount; } else { return 0; }
		}
		
		/**
		 * Adds a stack of items to the inventory.
		 * @param	itemstack	The ItemStack to add
		 * @return	The excess ItemStack i.e., the items that did not fit in this stack.
		 */
		public function addItemStack(itemstack:ItemStack):ItemStack
		{
			var excess:int = addItem(itemstack.item, itemstack.count);
			return (excess == 0) ? null : new ItemStack(itemstack.item, excess);
		}
		
		/**
		 * Removes an item by the given name.
		 * @param	name	The name of the item to be removed
		 * @param	amount	The amount of the item to remove
		 * @return	The itemstack that was removed
		 */
		public function removeByName(name:String, amount:uint = 1):ItemStack
		{
			var result:ItemStack = null;
			loop: for (var i:uint = 0; i < _items.length; i++) {
				if (_items[i]) { 
					if (_items[i].item.name == name) {
						var tempAmount:uint = amount;
						if (amount > _items[i].count) {
							amount -= _items[i].count;
						} else {
							amount = 0
						}
						result = removeBySlot(i, tempAmount);
					}
					if (amount <= 0) { break loop; }
				}
			}
			
			return result;
		}
		
		/**
		 * Removes a specified amount of the item at the given slot.
		 * @param	slot	The slot to remove from
		 * @param	amount	The amount to remove
		 * @return	The itemstack removed
		 */
		public function removeBySlot(slot:int, amount:uint = 1):ItemStack
		{
			var result:ItemStack = null;
			if (_items[slot]) {
				if (_items[slot].count - amount > 0) {
					result =  new ItemStack(_items[slot].item, amount); // return new item stack of amount
					_items[slot].remove(amount); // remove amount
				} else {
					result =  new ItemStack(_items[slot].item, _items[slot].count); // remove stack entirely
					_items[slot] = null;
				}
			} 
			return result;
		}
		
		/**
		 * Gets the item at the specified slot, but does not remove it.
		 * @param	slot	The slot to get the item from
		 * @return	The item at the slot
		 */
		public function getBySlot(slot:uint):ItemStack
		{
			return (_items[slot]) ? _items[slot] : null;
		}
		
		/**
		 * Gets the size of the inventory
		 */
		public function get size():int { return _size; }
	}

}