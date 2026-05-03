%module sqlitelib

%{
#include "sqlitelib.h"
using namespace sqlitelib;
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
