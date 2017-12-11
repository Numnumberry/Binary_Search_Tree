generic
	type Akey is private;
	type BinarySearchTreeRecord is private;
	with function "<"(TheKey: in Akey; ARecord: in BinarySearchTreeRecord)
		return Boolean;
	with function ">"(TheKey: in Akey; ARecord: in BinarySearchTreeRecord)
		return Boolean;
	with function "="(TheKey: in Akey; ARecord: in BinarySearchTreeRecord)
		return Boolean;
	with procedure fillRecordFields(ARecord: in out BinarySearchTreeRecord;
		key1: Akey; key2: Akey);
	with procedure print(ARecord: in out BinarySearchTreeRecord);
package gBST is

	type string10 is new String(1..10);	--may not need in end

	type BinarySearchTreePoint is limited private;
	
	procedure InsertBinarySearchTree(Root: in out BinarySearchTreePoint;
		custName: in Akey; custPhone: Akey);
	procedure DeleteRandomNode(DeletePoint: in BinarySearchTreePoint);
	procedure FindCustomerIterative(Root: in BinarySearchTreePoint; 
		CustomerName: in AKey;
		CustomerPoint: out BinarySearchTreePoint);
	procedure FindCustomerRecursive(Root: in BinarySearchTreePoint; 
		CustomerName: in AKey;
		CustomerPoint: out BinarySearchTreePoint);
	function InOrderSuccessor(TreePoint: in BinarySearchTreePoint) 
		return BinarySearchTreePoint;
	function PreOrderSuccessor(TreePoint: in BinarySearchTreePoint) 
		return BinarySearchTreePoint;
	function PostOrderPredecessor(TreePoint: in BinarySearchTreePoint) 
		return BinarySearchTreePoint;
	function CustomerName(TreePoint: in BinarySearchTreePoint) return string10;
	function CustomerPhone(TreePoint: in BinarySearchTreePoint) return string10;
	procedure PreOrder(TreePoint: in out BinarySearchTreePoint);
	procedure InOrder(TreePoint: in out BinarySearchTreePoint; phone: boolean);
	procedure PostOrderIterative(TreePoint: in out BinarySearchTreePoint);
	procedure PostOrderRecursive(TreePoint: in out BinarySearchTreePoint; isNull: boolean);
	procedure ReverseInOrder(TreePoint: in out BinarySearchTreePoint; isNull: boolean);
	procedure process;
	
	private
	type Node;
	type BinarySearchTreePoint is access Node;
	type Node is 
		record
			Llink, Rlink: BinarySearchTreePoint;
			Ltag, Rtag: boolean;
			Info: BinarySearchTreeRecord;
		end record;
end gBST;