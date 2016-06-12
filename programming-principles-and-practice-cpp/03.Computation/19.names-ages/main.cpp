#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

vector<string> names;
vector<int> ages;

bool name_exists(string name)
{
    for (int cnt = 0; cnt < names.size(); ++cnt)
    {
        if (names[cnt] == name)
        {
            return true;
        }
    }

    return false;
}

void store_info(string name, int age)
{
    names.push_back(name);
    ages.push_back(age);
}

void print_info(int index)
{
    cout << names[index] << " --> " << ages[index] << endl;
}

bool is_number(string input)
{
    string::const_iterator it = input.begin();
    while (it != input.end() && isdigit(*it))
    {
        ++it;
    }

    return !input.empty() && it == input.end();
}

void print_names_with_age(string input)
{
    if (is_number(input))
    {
        int age = atoi(input.c_str());

        for (int cnt = 0; cnt < ages.size(); ++cnt)
        {
            if (ages[cnt] == age)
            {
                print_info(cnt);
            }
        }
    }
    else
    {
        for (int cnt = 0; cnt < names.size(); ++cnt)
        {
            if (names[cnt] == input)
            {
                print_info(cnt);
            }
        }

    }
}

int main()
{
    string name;
    int age;
    int index;

    while (cin >> name >> age)
    {
        if (!name_exists(name))
        {
            cout << "Duplicate name" << endl;
        }
        else
        {
            store_info(name, age);
        }
    }

    cin.clear();

    while ((cin >> name) && name != "end")
    {
        print_names_with_age(name);
    }

    return 0;
}
