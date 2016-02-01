#include <iostream>
#include "quick-union.h"

using namespace std;

QUnion::QUnion(int elementsCnt) {
    this->elements = new int[elementsCnt];
    this->sizes = new int[elementsCnt];
    this->elementsCnt = elementsCnt;

    for (int index = 0; index < elementsCnt; ++index) {
        this->elements[index] = index;
        this->sizes[index] = 1;
    }
}

QUnion::~QUnion() {
    delete[] this->elements;
    delete[] this->sizes;
}

int QUnion::findRoot(int node) {
    int root = node;
    while(this->elements[root] != root) {
        elements[root] = elements[elements[root]];
        root = elements[root];
    }

    return root;
}

void QUnion::createUnion(int first, int second) {
    int firstRoot = this->findRoot(first);
    int secondRoot = this->findRoot(second);

    if (firstRoot == secondRoot) {
        return;
    }

    if (this->sizes[firstRoot] > this->sizes[secondRoot]) {

        this->elements[secondRoot] = this->elements[firstRoot];
        this->sizes[firstRoot] += this->sizes[secondRoot];
    } else {
        this->elements[firstRoot] = this->elements[secondRoot];
        this->sizes[secondRoot] += this->sizes[firstRoot];
    }
}

bool QUnion::areConnected(int first, int second) {
    return this->findRoot(first) == this->findRoot(second);
}

void QUnion::print() {
    int index;

    for (index = 0; index < this->elementsCnt; ++index) {
        cout << index << " ";
    }

    cout << endl;

    for (index = 0; index < this->elementsCnt; ++index) {
        cout << this->elements[index] << " ";
    }

    cout << endl;
}
