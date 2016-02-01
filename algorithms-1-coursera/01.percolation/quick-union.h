#ifndef QUICK_UNION_H
#define QUICK_UNION_H

class QUnion {
    public:
        QUnion(int elementsCnt);
        ~QUnion();
        void createUnion(int first, int second);
        bool areConnected(int first, int second);
        void print();
    private:
        int findRoot(int node);
        int * elements;
        int * sizes;
        int elementsCnt;
};

#endif // QUICK_UNION_H

