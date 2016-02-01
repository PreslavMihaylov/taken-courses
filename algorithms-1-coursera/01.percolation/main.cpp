#include <iostream>
#include <stdlib.h>
#include <time.h>

#include "quick-union.h"
#include "percolation.h"

using namespace std;

int main()
{
    // Quick Union tests
    QUnion q(10);
    q.createUnion(2, 4);
    q.createUnion(5, 4);
    q.createUnion(5, 6);
    q.createUnion(8, 6);
    q.print();
    cout << q.areConnected(2, 4) << endl;
    cout << q.areConnected(5, 4) << endl;
    cout << q.areConnected(5, 6) << endl;
    cout << q.areConnected(6, 8) << endl;

    // Percolation tests
    Percolation p(5);

    p.open(1,1);
    p.print();
    cout << p.doesPercolate() << endl;

    p.open(1,2);
    p.print();
    cout << p.doesPercolate() << endl;

    p.open(1, 3);
    p.print();
    cout << p.doesPercolate() << endl;

    p.open(1, 4);
    p.print();
    cout << p.doesPercolate() << endl;


    p.open(2, 4);
    p.print();
    cout << p.doesPercolate() << endl;


    p.open(2, 3);
    p.print();
    cout << p.doesPercolate() << endl;

    p.open(2, 2);
    p.print();
    cout << p.doesPercolate() << endl;

    p.open(2, 1);
    p.print();
    cout << p.doesPercolate() << endl;

    p.open(3, 0);
    p.print();
    cout << p.doesPercolate() << endl;

    p.open(3, 1);
    p.print();
    cout << p.doesPercolate() << endl;

    // Median tests
    int dimensions = 200;
    int totalTests = 100;
    int openSitesCnt = 0;
    double median = 0;
    srand(time(NULL));

    for (int testCnt = 0; testCnt < totalTests; ++testCnt) {
        Percolation perc(dimensions);
        while (!perc.doesPercolate()) {
            int row;
            int col;
            do {
                row = rand() % dimensions;
                col = rand() % dimensions;
            } while (perc.isOpen(row, col));

            perc.open(row, col);
            ++openSitesCnt;
        }

        cout << "Open sites: " << openSitesCnt << "/" << (dimensions * dimensions) << endl;
        median += (double)openSitesCnt / (dimensions * dimensions);
        openSitesCnt = 0;
    }

    cout << "Mean: " << (median / totalTests) << endl;

    return 0;
}
