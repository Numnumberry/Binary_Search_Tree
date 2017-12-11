with Ada.Text_IO; use Ada.Text_IO;
with Unchecked_Conversion;

package body gBST is
	
	type Customer is
		record
			Name: string10;
			PhoneNumber: string10;
		end record;
		
	function Str2Key is new Unchecked_Conversion(string10, AKey);	
	function Rec2Cus is new Unchecked_Conversion(BinarySearchTreeRecord, Customer);
		
	Root: BinarySearchTreePoint := new Node;
	treeCount: integer := 1;
	Stack: array(1..20) of BinarySearchTreePoint;
	count: integer := 1;
	
	procedure createRoot is
		newRecord: BinarySearchTreeRecord;
	begin
		fillRecordFields(newRecord, Str2Key("ROOT      "), Str2Key("----------"));
		Root.Info := newRecord;
		Root.RTag := true;
		Root.LTag := false;
		Root.Rlink := Root;
		Root.Llink := Root;
	end createRoot;
	
	procedure InsertBinarySearchTree(Root: in out BinarySearchTreePoint;
		custName: in Akey; custPhone: Akey) is
		
		P: BinarySearchTreePoint;
		Q: BinarySearchTreePoint := new Node;
		newRecord: BinarySearchTreeRecord;
	begin
		fillRecordFields(newRecord, custName, custPhone);
		Q.Info := newRecord;
		Q.RTag := false;
		Q.LTag := false;
		
		if Root.LTag = false then		--if empty
			Root.Llink := Q;
			Root.LTag := true;
			Q.Llink := Root;
			Q.Rlink := Root;
		else
			P := Root.Llink;
			loop
				if custName < P.Info then
					if P.LTag = true then
						P := P.Llink;
					else
						Q.Llink := P.Llink;			-----LEFTINSERT--------
						Q.LTag := P.LTag;
						P.Llink := Q;
						P.LTag := true;
						Q.Rlink := P;
						Q.RTag := false;
						if Q.LTag = true then
							P := Q.Llink;
							while P.RTag = true loop
								P := P.Rlink;
							end loop;
							P.Rlink := Q;
						end if;						----------------------
						exit;
					end if;
				elsif custName > P.Info then
					if P.RTag = true then
						P := P.Rlink;
					else
						Q.Rlink := P.Rlink;			--------RIGHTINSERT-----
						Q.RTag := P.RTag;						
						P.Rlink := Q;
						P.RTag := true;
						Q.Llink := P;
						Q.LTag := false;
						if Q.RTag = true then
							P := Q.Rlink;
							while P.LTag = true loop
								P := P.Llink;
							end loop;
							P.Llink := Q;
						end if;						-----------------------
						exit;
					end if;
				else
					if P.RTag = false then
						Q.Rlink := P.Rlink;			--------RIGHTINSERT-----
						Q.RTag := P.RTag;						
						P.Rlink := Q;
						P.RTag := true;
						Q.Llink := P;
						Q.LTag := false;
						if Q.RTag = true then
							P := Q.Rlink;
							while P.LTag = true loop
								P := P.Llink;
							end loop;
							P.Llink := Q;
						end if;						-----------------------
					else
						P := P.Rlink;
						while P.LTag = true loop
							P := P.Llink;
						end loop;
						Q.Llink := P.Llink;			-----LEFTINSERT--------
						Q.LTag := P.LTag;
						P.Llink := Q;
						P.LTag := true;
						Q.Rlink := P;
						Q.RTag := false;
						if Q.LTag = true then
							P := Q.Llink;
							while P.RTag = true loop
								P := P.Rlink;
							end loop;
							P.Rlink := Q;
						end if;						----------------------
					end if;
					exit;
				end if;
			end loop;
		end if;
	end InsertBinarySearchTree;
	
	--THE DELETE FUNCTION DOES NOT WORK, HENCE WHY IT IS COMMENTED OUT BELOW WHEN CALLED
	procedure DeleteRandomNode(DeletePoint: in BinarySearchTreePoint) is
		T: BinarySearchTreePoint;
		Q: BinarySearchTreePoint := DeletePoint;
		S: BinarySearchTreePoint;
		R: BinarySearchTreePoint;
		P: BinarySearchTreePoint;
	begin
		T := Q;
		if T.RTag = false then
			Q := T.Llink;
			T := new Node;
		else
			if T.LTag = false then
				Q := T.Rlink;
				T := new Node;
			end if;
			R := T.Rlink;
			if R.LTag = false then
				R.Llink := T.Llink;
				Q := R;
				T := new Node;
			else
				S := R.Llink;
				while S.LTag = true loop
					R := S;
					S := R.Llink;
				end loop;
				S.Llink := T.Llink;
				R.Llink := S.Rlink;
				S.Rlink := T.RLink;
				Q := S;
				T := new Node;
			end if;
		end if;
		if P = Root.Llink then  --since threaded, my root is actually Llink of "Root"
			Root.Llink := Q;
		else
			if Q = P.Llink then
				P.Llink := Q;
			else
				P.Rlink := Q;
			end if;
		end if;
	end DeleteRandomNode;
	
	procedure FindCustomerIterative(Root: in BinarySearchTreePoint;
		CustomerName: in AKey;
		CustomerPoint: out BinarySearchTreePoint) is
	
		P: BinarySearchTreePoint;
	begin
		if Root.LTag = false then		--if empty
			put_line("Tree is empty!");
		else
			P := Root.Llink;
			loop
				if CustomerName < P.Info then
					if P.LTag = true then
						P := P.Llink;
					else
						put_line("Not in tree!");
						exit;
					end if;
				elsif CustomerName > P.info then
					if P.RTag = true then
						P := P.Rlink;
					else
						put_line("Not in tree!");
						exit;
					end if;
				else
					CustomerPoint := P;
					exit;
				end if;
			end loop;
		end if;
	end FindCustomerIterative;
	
	procedure FindCustomerRecursive(Root: in BinarySearchTreePoint; 
		CustomerName: in AKey;
		CustomerPoint: out BinarySearchTreePoint) is
	begin
		if Str2Key("ROOT      ") = Root.Info then
			FindCustomerRecursive(Root.Llink, CustomerName, CustomerPoint);
		elsif CustomerName < Root.Info then
			if Root.LTag = true then
				FindCustomerRecursive(Root.Llink, CustomerName, CustomerPoint);
			else
				put_line("Not in tree!");
			end if;
		elsif CustomerName > Root.Info then
			if Root.RTag = true then
				FindCustomerRecursive(Root.Rlink, CustomerName, CustomerPoint);
			else
				put_line("Not in tree!");
			end if;
		else
			CustomerPoint := Root;
		end if;
	end FindCustomerRecursive;
	
	function InOrderSuccessor(TreePoint: in BinarySearchTreePoint) 
		return BinarySearchTreePoint is
		
		Q: BinarySearchTreePoint;
	begin
		Q := TreePoint.Rlink;
		if TreePoint.RTag = false then
			null;
		else
			while Q.LTag = true loop
				Q := Q.Llink;
			end loop;
		end if;
		return Q;
	end InOrderSuccessor;
	
	function PreOrderSuccessor(TreePoint: in BinarySearchTreePoint) 
		return BinarySearchTreePoint is
		
		Q: BinarySearchTreePoint;
	begin
		if TreePoint.LTag = true then
			Q := TreePoint.Llink;
		else
			Q := TreePoint;
			while Q.RTag = false loop
				Q := Q.Rlink;
			end loop;
			Q := Q.Rlink;
		end if;
		return Q;
	end PreOrderSuccessor;
	
	function PostOrderPredecessor(TreePoint: in BinarySearchTreePoint) 
		return BinarySearchTreePoint is
		
		Q: BinarySearchTreePoint := TreePoint;
	begin
		if TreePoint.RTag = true then
			if Rec2Cus(TreePoint.Info).Name = "ROOT      " then
				Q := TreePoint.Llink;
			else
				Q := TreePoint.Rlink;
			end if;
		else
			while Q.LTag = false loop
				Q := Q.Llink;
			end loop;
			Q := Q.Llink;
		end if;
		return Q;
	end PostOrderPredecessor;
	
	function CustomerName(TreePoint: in BinarySearchTreePoint) return string10 is
	begin
		return Rec2Cus(TreePoint.Info).Name;
	end CustomerName;
	
	function CustomerPhone(TreePoint: in BinarySearchTreePoint) return string10 is
	begin
		return Rec2Cus(TreePoint.Info).PhoneNumber;
	end CustomerPhone;
	
	procedure PreOrder(TreePoint: in out BinarySearchTreePoint) is
		P: BinarySearchTreePoint := TreePoint;
	begin
		for i in 1..treeCount loop
			if Rec2Cus(P.Info).Name /= "ROOT      " then
				print(P.Info); new_line;
			end if;
			P := PreOrderSuccessor(P);
		end loop;
	end PreOrder;
	
	procedure InOrder(TreePoint: in out BinarySearchTreePoint; phone: boolean) is
		P: BinarySearchTreePoint := TreePoint;
	begin
		for i in 1..treeCount loop
			if Rec2Cus(P.Info).Name /= "ROOT      " then
				print(P.Info);
				if phone = false then
					new_line;
				end if;
				if phone = true then
					for i in 1..10 loop
						put(Rec2Cus(P.Info).PhoneNumber(i));
					end loop;
					new_line;
				end if;
			end if;
			P := InOrderSuccessor(P);
		end loop;
	end InOrder;
	
	procedure PostOrderIterative(TreePoint: in out BinarySearchTreePoint) is
		P: BinarySearchTreePoint := TreePoint;
	begin
		for i in 1..treeCount loop
			Stack(i) := P;
			P := PostOrderPredecessor(P);
		end loop;
		for i in reverse 1..treeCount loop
			if Rec2Cus(Stack(i).Info).Name /= "ROOT      " then
				print(Stack(i).Info); new_line;
			end if;
		end loop;
	end PostOrderIterative;
	
	procedure PostOrderRecursive(TreePoint: in out BinarySearchTreePoint; isNull: boolean) is
	begin
		if count < treeCount and isNull /= true then
			if TreePoint.LTag = false then
				PostOrderRecursive(TreePoint.Llink, true);
			else
				PostOrderRecursive(TreePoint.Llink, false);
			end if;
			if TreePoint.RTag = false then
				PostOrderRecursive(TreePoint.Rlink, true);
			else
				PostOrderRecursive(TreePoint.Rlink, false);
			end if;
			if Rec2Cus(TreePoint.Info).Name /= "ROOT      " then
				print(TreePoint.Info); new_line;
				count := count + 1;
			end if;
		end if;
	end PostOrderRecursive;
	
	procedure ReverseInOrder(TreePoint: in out BinarySearchTreePoint; isNull: boolean) is	--not done
	begin
		if count < treeCount and isNull /= true then
			if TreePoint.RTag = false then
				ReverseInOrder(TreePoint.Rlink, true);
			else
				ReverseInOrder(TreePoint.Rlink, false);
			end if;
			if Rec2Cus(TreePoint.Info).Name /= "ROOT      " then
				print(TreePoint.Info);
				count := count + 1;
			end if;
			if TreePoint.LTag = false then
				ReverseInOrder(TreePoint.Llink, true);
			else
				ReverseInOrder(TreePoint.Llink, false);
			end if;
		end if;
	end ReverseInOrder;
	
	procedure process is
		temp: BinarySearchTreePoint;
	begin
		createRoot;
		put_line("C:--------------------------------");
		InsertBinarySearchTree(Root, Str2Key("Ajose     "), Str2Key("295-1492  "));
		treeCount := treeCount + 1;
		InsertBinarySearchTree(Root, Str2Key("Munoz     "), Str2Key("291-1864  "));
		treeCount := treeCount + 1;
		InsertBinarySearchTree(Root, Str2Key("Kong      "), Str2Key("295-1601  "));
		treeCount := treeCount + 1;
		InsertBinarySearchTree(Root, Str2Key("Saleem    "), Str2Key("293-6122  "));
		treeCount := treeCount + 1;
		InsertBinarySearchTree(Root, Str2Key("Seddon    "), Str2Key("295-1882  "));
		treeCount := treeCount + 1;
		InsertBinarySearchTree(Root, Str2Key("Najar     "), Str2Key("291-7890  "));
		treeCount := treeCount + 1;
		InsertBinarySearchTree(Root, Str2Key("Voorhees  "), Str2Key("294-8075  "));
		treeCount := treeCount + 1;
		InsertBinarySearchTree(Root, Str2Key("Sparks    "), Str2Key("584-3622  "));
		treeCount := treeCount + 1;
		
		FindCustomerIterative(Root, Str2Key("Saleem    "), temp);
		for i in 1..10 loop
			put(Rec2Cus(temp.Info).PhoneNumber(i));
		end loop; new_line;
		FindCustomerRecursive(Root, Str2Key("Saleem    "), temp);
		for i in 1..10 loop
			put(Rec2Cus(temp.Info).PhoneNumber(i));
		end loop; new_line;
		FindCustomerIterative(Root, Str2Key("Acevedo   "), temp);
		FindCustomerRecursive(Root, Str2Key("Acevedo   "), temp); new_line;
		FindCustomerIterative(Root, Str2Key("Najar     "), temp);
		InOrder(temp, false); new_line;
		InsertBinarySearchTree(Root, Str2Key("Devin     "), Str2Key("294-1568  "));
		treeCount := treeCount + 1;
		InsertBinarySearchTree(Root, Str2Key("Morah     "), Str2Key("294-1882  "));
		treeCount := treeCount + 1;
		InsertBinarySearchTree(Root, Str2Key("Zembo     "), Str2Key("295-6622  "));
		treeCount := treeCount + 1;
		InOrder(Root, true);
		put_line("B----------------------------------");
		FindCustomerIterative(Root, Str2Key("Ajose     "), temp); 
		--DeleteRandomNode(temp);
		FindCustomerIterative(Root, Str2Key("Najar     "), temp);
		--DeleteRandomNode(temp);
		FindCustomerIterative(Root, Str2Key("Aguirra   "), temp);
		--DeleteRandomNode(temp);
		InsertBinarySearchTree(Root, Str2Key("Novak     "), Str2Key("294-1666  "));
		treeCount := treeCount + 1;
		InsertBinarySearchTree(Root, Str2Key("Gonzales  "), Str2Key("295-1882  "));
		treeCount := treeCount + 1;
		InOrder(Root, true); new_line;
		--reverseinorder(Root, true);
		PreOrder(Root);
		put_line("A----------------------------------");
		PostOrderIterative(Root); new_line;
		PostOrderRecursive(Root, false);
	end process;
begin
	process;
end gBST;
