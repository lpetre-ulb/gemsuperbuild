#include <occi.h>

#include <cstdlib>
#include <cstring>
#include <string>

using namespace oracle::occi;

namespace helpers {

[[gnu::visibility("internal")]] std::string from_char_ptr(char* safe)
{
  // We need to copy "safe" and free it.
  std::string result(safe);
  std::free(safe);
  return result;
}

[[gnu::visibility("internal")]] char* to_char_ptr(const std::string& unsafe)
{
  // We need to copy "unsafe" and free it.
  char* safe = (char*)malloc(unsafe.size() + 1);
  if (safe == nullptr) {
    throw std::bad_alloc();
  }
  std::memcpy(safe, unsafe.data(), unsafe.size() + 1);
  return safe;
}

} // namespace helpers

////////////////////////////////////////////////////////////////////////////////
// Date::toText
////////////////////////////////////////////////////////////////////////////////

namespace wrapper {

[[gnu::visibility("internal")]] char* toText(const Date* o,
                                             const char* p0,
                                             const char* p1)
#if _GLIBCXX_USE_CXX11_ABI
  ;
#else  // _GLIBCXX_USE_CXX11_ABI
{
  return helpers::to_char_ptr(o->toText(p0, p1));
}
#endif // _GLIBCXX_USE_CXX11_ABI

} // namespace wrapper

#if _GLIBCXX_USE_CXX11_ABI
std::string Date::toText(const std::string& fmt,
                         const std::string& nlsParam) const
{
  return helpers::from_char_ptr(
    wrapper::toText(this, fmt.data(), nlsParam.data()));
}
#endif // _GLIBCXX_USE_CXX11_ABI

////////////////////////////////////////////////////////////////////////////////
// IntervalDS::toText
////////////////////////////////////////////////////////////////////////////////

namespace wrapper {

[[gnu::visibility("internal")]] char* toText(const IntervalDS* o,
                                             unsigned int p0,
                                             unsigned int p1,
                                             const char* p2)
#if _GLIBCXX_USE_CXX11_ABI
  ;
#else  // _GLIBCXX_USE_CXX11_ABI
{
  return helpers::to_char_ptr(o->toText(p0, p1, p2));
}
#endif // _GLIBCXX_USE_CXX11_ABI

} // namespace wrapper

#if _GLIBCXX_USE_CXX11_ABI
std::string IntervalDS::toText(unsigned int lfprec,
                               unsigned int fsprec,
                               const std::string& nlsParam) const
{
  return helpers::from_char_ptr(
    wrapper::toText(this, lfprec, fsprec, nlsParam.data()));
}
#endif // _GLIBCXX_USE_CXX11_ABI

////////////////////////////////////////////////////////////////////////////////
// IntervalYM::toText
////////////////////////////////////////////////////////////////////////////////

namespace wrapper {

[[gnu::visibility("internal")]] char* toText(const IntervalYM* o,
                                             unsigned int p0,
                                             const char* p1)
#if _GLIBCXX_USE_CXX11_ABI
  ;
#else  // _GLIBCXX_USE_CXX11_ABI
{
  return helpers::to_char_ptr(o->toText(p0, p1));
}
#endif // _GLIBCXX_USE_CXX11_ABI

} // namespace wrapper

#if _GLIBCXX_USE_CXX11_ABI
std::string IntervalYM::toText(unsigned int lfprec,
                               const std::string& nlsParam) const
{
  return helpers::from_char_ptr(wrapper::toText(this, lfprec, nlsParam.data()));
}
#endif // _GLIBCXX_USE_CXX11_ABI

////////////////////////////////////////////////////////////////////////////////
// Metadata::getString
////////////////////////////////////////////////////////////////////////////////

namespace wrapper {

[[gnu::visibility("internal")]] char* getString(const MetaData* o,
                                                MetaData::AttrId p0)
#if _GLIBCXX_USE_CXX11_ABI
  ;
#else  // _GLIBCXX_USE_CXX11_ABI
{
  return helpers::to_char_ptr(o->getString(p0));
}
#endif // _GLIBCXX_USE_CXX11_ABI

} // namespace wrapper

#if _GLIBCXX_USE_CXX11_ABI
std::string MetaData::getString(MetaData::AttrId attrid) const
{
  return helpers::from_char_ptr(wrapper::getString(this, attrid));
}
#endif // _GLIBCXX_USE_CXX11_ABI

////////////////////////////////////////////////////////////////////////////////
// Number::fromText
////////////////////////////////////////////////////////////////////////////////

namespace wrapper {

[[gnu::visibility("internal")]] void fromText(Number* o,
                                              const Environment* p0,
                                              const char* p1,
                                              const char* p2,
                                              const char* p3)
#if _GLIBCXX_USE_CXX11_ABI
  ;
#else  // _GLIBCXX_USE_CXX11_ABI
{
  o->fromText(p0, p1, p2, p3);
}
#endif // _GLIBCXX_USE_CXX11_ABI

} // namespace wrapper

#if _GLIBCXX_USE_CXX11_ABI
void Number::fromText(const Environment* envp,
                      const std::string& number,
                      const std::string& fmt,
                      const std::string& nlsParam)
{
  wrapper::fromText(this, envp, number.data(), fmt.data(), nlsParam.data());
}
#endif // _GLIBCXX_USE_CXX11_ABI

////////////////////////////////////////////////////////////////////////////////
// Number::toText
////////////////////////////////////////////////////////////////////////////////

namespace wrapper {

[[gnu::visibility("internal")]] char* toText(const Number* o,
                                             const Environment* p0,
                                             const char* p1,
                                             const char* p2)
#if _GLIBCXX_USE_CXX11_ABI
  ;
#else  // _GLIBCXX_USE_CXX11_ABI
{
  return helpers::to_char_ptr(o->toText(p0, p1, p2));
}
#endif // _GLIBCXX_USE_CXX11_ABI

} // namespace wrapper

#if _GLIBCXX_USE_CXX11_ABI
std::string Number::toText(const Environment* envp,
                           const std::string& fmt,
                           const std::string& nlsParam) const
{
  return helpers::from_char_ptr(
    wrapper::toText(this, envp, fmt.data(), nlsParam.data()));
}
#endif // _GLIBCXX_USE_CXX11_ABI

////////////////////////////////////////////////////////////////////////////////
// Timestamp::fromText
////////////////////////////////////////////////////////////////////////////////

namespace wrapper {

[[gnu::visibility("internal")]] void fromText(Timestamp* o,
                                              const char* p0,
                                              const char* p1,
                                              const char* p2,
                                              const Environment* p3)
#if _GLIBCXX_USE_CXX11_ABI
  ;
#else  // _GLIBCXX_USE_CXX11_ABI
{
  o->fromText(p0, p1, p2, p3);
}
#endif // _GLIBCXX_USE_CXX11_ABI

} // namespace wrapper

#if _GLIBCXX_USE_CXX11_ABI
void Timestamp::fromText(const std::string& timestmpStr,
                         const std::string& fmt,
                         const std::string& nlsParam,
                         const Environment* env)
{
  wrapper::fromText(this, timestmpStr.data(), fmt.data(), nlsParam.data(), env);
}
#endif // _GLIBCXX_USE_CXX11_ABI

////////////////////////////////////////////////////////////////////////////////
// Timestamp::toText
////////////////////////////////////////////////////////////////////////////////

namespace wrapper {

[[gnu::visibility("internal")]] char* toText(const Timestamp* o,
                                             const char* p0,
                                             unsigned int p1,
                                             const char* p2)
#if _GLIBCXX_USE_CXX11_ABI
  ;
#else  // _GLIBCXX_USE_CXX11_ABI
{
  return helpers::to_char_ptr(o->toText(p0, p1, p2));
}
#endif // _GLIBCXX_USE_CXX11_ABI

} // namespace wrapper

#if _GLIBCXX_USE_CXX11_ABI
std::string Timestamp::toText(const std::string& fmt,
                              unsigned int fsprec,
                              const std::string& nlsParam) const
{
  return helpers::from_char_ptr(
    wrapper::toText(this, fmt.data(), fsprec, nlsParam.data()));
}
#endif // _GLIBCXX_USE_CXX11_ABI
