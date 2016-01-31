#ifndef QUICK_UNION_H
#define QUICK_UNION_H

class QUnion {
	public:
		QUnion(int elementsCnt);
		void createUnion(int first, int second);
		bool isConnected(int first, int second);
	private:
		int * elements;
		int elementsCnt;
};


#endif // QUICK_UNION_H
