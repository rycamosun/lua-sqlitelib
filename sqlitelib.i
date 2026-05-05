%module sqlitelib

%{
#include "sqlitelib.h"
#include <sqlite3.h>
using namespace sqlitelib;
template<typename Tag, typename Tag::type M>
struct Rob { friend typename Tag::type get(Tag) { return M; } };
struct SqliteDb { typedef sqlite3* sqlitelib::Sqlite::*type; friend type get(SqliteDb); };
template struct Rob<SqliteDb, &sqlitelib::Sqlite::db_>;
%}

%include <std_string.i>
%include <std_vector.i>
%include <exception.i>

#pragma SWIG nowarn=302,509

%exception {
  try { $action }
  catch (const std::exception& e) {
    luaL_error(L, "%s", e.what()); return SWIG_ERROR;
  }
}

%template(VectorString) std::vector<std::string>;

namespace sqlitelib {

class Sqlite {
public:
  Sqlite(const char* path);
  ~Sqlite();
  bool is_open() const;
};

}

%extend sqlitelib::Sqlite {
  void execute(const char* q) { self->execute(q); }
  std::vector<std::string> execute_string(const char* q) {
    return self->execute<std::string>(q);
  }
}
