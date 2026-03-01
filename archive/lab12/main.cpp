#include <bits/stdc++.h>
#include <optional>

using namespace std;

const vector<pair<int, int>> directions = {
    {0, 1},
    {0, -1},
    {1, 0},
    {-1, 0},
    {1, 1},
    {1, -1},
    {-1, 1},
    {-1, -1}
};

class Labyrinth {
    public:
        pair<int, int> start_position;
        pair<int, int> end_position;
        vector<vector<bool>> play_zone;
        int width, height;
        int expanded;
    
        void read_labyrinth();
        optional<vector<pair<int, int>>> get_optimal_path(std::function<int(pair<int, int>)>);
        set<pair<int, int>> get_neighbours(pair<int, int>);
        void print_format(vector<pair<int, int>> &path);
};

set<pair<int, int>> Labyrinth::get_neighbours(pair<int, int> position)
{
    set<pair<int, int>> nei;

    for (auto &[row_diff, col_diff] : directions) {
        int new_row = position.first + row_diff;
        int new_col = position.second + col_diff;

        if (new_row < 0
            || new_col < 0
            || new_row >= this->height
            || new_col >= this->width
            || play_zone[new_row][new_col] == true) {
                continue;
        }

        pair<int, int> neigh = {new_row, new_col};

        nei.insert(neigh);
    }

    return nei;
}

void Labyrinth::read_labyrinth()
{
    cin >> width >> height;

    play_zone = vector<vector<bool>>(height, vector<bool>(width));

    for (int i = 0; i < height; ++i) {
        for (int j = 0; j < width; ++j) {
            int x;
            cin >> x;
            play_zone[i][j] = (x == 1);
        }
    }

    int start_row, start_col;
    cin >> start_row >> start_col;
    start_position = {start_row, start_col};
    
    int end_row, end_col;
    cin >> end_row >> end_col;
    end_position = {end_row, end_col};
}

optional<vector<pair<int, int>>> Labyrinth::get_optimal_path(std::function<int(pair<int, int>)> f)
{
    map<pair<int, int>, pair<int, pair<int, int>>> distances; // node -> {cost, parent}
    priority_queue<pair<int, pair<int, int>>,
                vector<pair<int, pair<int, int>>>,
                greater<pair<int, pair<int, int>>>> q;

    q.push({f(this->start_position), this->start_position});
    distances[start_position] = {0, {-1, -1}};

    bool found = false;

    while (!q.empty()) {
        pair<int, int> best = q.top().second;
        q.pop();
        
        if (best == this->end_position) {
            found = true;
            break;
        }
        
        auto [cost, parent] = distances[best];

        auto neighbours = this->get_neighbours(best);

        for (auto& nei : neighbours) {
            if (distances.find(nei) == distances.end()) {
                distances[nei] = {cost + 1, best};
                q.push({cost + 1 + f(nei), nei});
            } else {
                int new_cost = cost + 1;
                if (new_cost < distances[nei].first) {
                    distances[nei] = {new_cost, best};
                    q.push({new_cost + f(nei), nei});
                }
            }
        }
    }

    expanded = distances.size();
    if (found == false) {
        return std::nullopt;
    }

    vector<pair<int, int>> path;
    pair<int, int> state = this->end_position;

    while (true) {
        path.push_back(state);
        state = distances[state].second;

        if (state == start_position) {
            path.push_back(state);
            reverse(path.begin(), path.end());
            break;
        }
    }

    return optional<vector<pair<int, int>>>{path};
}

void Labyrinth::print_format(vector<pair<int, int>> &path)
{
    vector<vector<char>> matrix(height, vector<char>(width));

    for (int i = 0; i < height; ++i) {
        for(int j = 0; j < width; ++j) {
            matrix[i][j] = (play_zone[i][j] ? 'W' : '.');
        }
    }

    for (auto &pos : path) {
        int row = pos.first;
        int col = pos.second;

        if (pos == start_position) {
            matrix[row][col] = 'S';
        } else if (pos == end_position) {
            matrix[row][col] = 'E';
        } else {
            matrix[row][col] = 'P';
        }
    }

    for (int i = 0; i < height; ++i) {
        for (int j = 0; j < width; ++j)
            cout << matrix[i][j];

        cout << "\n";
    }
}

int main(void)
{
    Labyrinth *labyrinth = new Labyrinth;
    labyrinth->read_labyrinth();

    auto path = labyrinth->get_optimal_path([labyrinth] (pair<int, int> p) -> int {
        return max(abs(p.first - labyrinth->end_position.first), abs(p.second - labyrinth->end_position.second));
    });

    cout << "Expanded " << labyrinth->expanded << " states" << "\n";

    if (path.has_value()) {
        labyrinth->print_format(*path);
    } else {
        cerr << "There is no path!" << "\n";
    }

    delete labyrinth;
    return 0;
}