#ifndef PERCOLATION_H
#define PERCOLATION_H

#include "quick-union.h"

class Percolation {
    public:
        Percolation(int dimensions);
        ~Percolation();
        void open(int row, int col);
        bool isOpen(int row, int col);
        bool doesPercolate();
        void print();
    private:
        int getId(int row, int col);
        int getBotNode();
        int getTopNode();
        QUnion * data;
        bool * openSites;
        int dimensions;
};

#endif // PERCOLATION_H
