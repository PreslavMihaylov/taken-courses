#include <iostream>
#include "percolation.h"

using namespace std;

Percolation::Percolation(int dimensions) {
    this->data = new QUnion(dimensions * dimensions + 2);
    this->openSites = new bool[dimensions * dimensions]();
    this->dimensions = dimensions;

    for (int col = 0; col < dimensions; ++col) {
        // Create virtual top node
        int topCol = this->getId(0, col);
        int botCol = this->getId(dimensions - 1, col);
        this->data->createUnion(this->getTopNode(), topCol);

        // Create virtual bottom node
        this->data->createUnion(this->getBotNode(), botCol);

        this->openSites[topCol] = true;
        this->openSites[botCol] = true;
    }
}

Percolation::~Percolation() {
    delete this->data;
    delete[] this->openSites;
}

int Percolation::getBotNode() {
    return this->dimensions * this->dimensions;
}

int Percolation::getTopNode() {
    return this->dimensions * this->dimensions + 1;
}

int Percolation::getId(int row, int col) {
    return row * this->dimensions + col;
}

void Percolation::open(int row, int col) {
    int current = this->getId(row, col);
    int top = this->getId(row - 1, col);
    int right = this->getId(row, col + 1);
    int bot = this->getId(row + 1, col);
    int left = this->getId(row, col - 1);

    this->openSites[current] = true;

    if (this->isOpen(row - 1, col)) {
        this->data->createUnion(current, top);
        this->openSites[top] = true;
    }

    if (this->isOpen(row, col + 1)) {
        this->data->createUnion(current, right);
        this->openSites[right] = true;
    }

    if (this->isOpen(row + 1, col)) {
        this->data->createUnion(current, bot);
        this->openSites[bot] = true;
    }

    if (this->isOpen(row, col - 1)) {
        this->data->createUnion(current, left);
        this->openSites[left] = true;
    }
}

bool Percolation::isOpen(int row, int col) {
    if (col >= 0 && col < this->dimensions && row >= 0 && row < this->dimensions) {
        return openSites[this->getId(row, col)];
    }

    return false;
}

bool Percolation::doesPercolate() {
    int botNode = this->getBotNode();
    int topNode = this->getTopNode();

    if (this->data->areConnected(botNode, topNode)) {
        return true;
    }

    return false;
}

void Percolation::print() {
    for (int row = 0; row < this->dimensions; ++row) {
        for (int col = 0; col < this->dimensions; ++col) {
            if (this->isOpen(row, col)) {
                cout << "1 ";
            } else {
                cout << "0 ";
            }
        }

        cout << endl;
    }
}
