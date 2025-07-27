import 'package:betterloop/models/icon_meta.dart';
import 'package:flutter/material.dart';

class EffeciencyIcons {
  EffeciencyIcons._();

  static const String _kFontFam = 'EfficiencyIcons';

  static const IconData trash_svgrepo_com =
      IconData(0xe900, fontFamily: _kFontFam);
  static const IconData statistics_svgrepo_com =
      IconData(0xe901, fontFamily: _kFontFam);
  static const IconData book_bookmark_minimalistic_svgrepo_com_edit =
      IconData(0xe902, fontFamily: _kFontFam);
  static const IconData truck_fast_svgrepo_com =
      IconData(0xe903, fontFamily: _kFontFam);
  static const IconData tshirt_t_shirt_recycle =
      IconData(0xe904, fontFamily: _kFontFam);
  static const IconData book_bookmark_svgrepo_com =
      IconData(0xe905, fontFamily: _kFontFam);
  static const IconData calendar_edit_svgrepo_com =
      IconData(0xe906, fontFamily: _kFontFam);
  static const IconData calendar_time_near_deadline =
      IconData(0xe907, fontFamily: _kFontFam);
  static const IconData calendar_time_one_third =
      IconData(0xe908, fontFamily: _kFontFam);
  static const IconData conversation = IconData(0xe909, fontFamily: _kFontFam);
  static const IconData document_deadline_time =
      IconData(0xe90a, fontFamily: _kFontFam);
  static const IconData envelope_on_time =
      IconData(0xe90b, fontFamily: _kFontFam);
  static const IconData folder_open_svgrepo_com =
      IconData(0xe90c, fontFamily: _kFontFam);
  static const IconData notebook_of_contacts_svgrepo_com =
      IconData(0xe90d, fontFamily: _kFontFam);
  static const IconData shopping_cart_list =
      IconData(0xe90e, fontFamily: _kFontFam);
  static const IconData tasks_cog = IconData(0xe90f, fontFamily: _kFontFam);
  static const IconData answer_student_svgrepo_com =
      IconData(0xe911, fontFamily: _kFontFam);

  static final List<IconMeta> iconMetaList = [
    IconMeta(trash_svgrepo_com, 'trash_svgrepo_com',
        ['delete', 'waste', 'clean', 'remove', 'efficiency']),
    IconMeta(statistics_svgrepo_com, 'statistics_svgrepo_com',
        ['data', 'chart', 'performance', 'metrics', 'analytics']),
    IconMeta(
        book_bookmark_minimalistic_svgrepo_com_edit,
        'book_bookmark_minimalistic_svgrepo_com_edit',
        ['book', 'reading', 'study', 'notes', 'edit']),
    IconMeta(truck_fast_svgrepo_com, 'truck_fast_svgrepo_com',
        ['delivery', 'truck', 'fast', 'shipping', 'logistics']),
    IconMeta(tshirt_t_shirt_recycle, 'tshirt_t_shirt_recycle',
        ['recycle', 'clothing', 'tshirt', 'eco', 'reuse']),
    IconMeta(book_bookmark_svgrepo_com, 'book_bookmark_svgrepo_com',
        ['book', 'bookmark', 'reading', 'study']),
    IconMeta(calendar_edit_svgrepo_com, 'calendar_edit_svgrepo_com',
        ['calendar', 'schedule', 'edit', 'plan', 'organize']),
    IconMeta(calendar_time_near_deadline, 'calendar_time_near_deadline',
        ['deadline', 'calendar', 'time', 'urgent', 'reminder']),
    IconMeta(calendar_time_one_third, 'calendar_time_one_third',
        ['calendar', 'progress', 'time', 'schedule']),
    IconMeta(conversation, 'conversation',
        ['chat', 'talk', 'discussion', 'communication']),
    IconMeta(document_deadline_time, 'document_deadline_time',
        ['document', 'deadline', 'submission', 'paperwork', 'urgency']),
    IconMeta(envelope_on_time, 'envelope_on_time',
        ['email', 'on time', 'message', 'communication']),
    IconMeta(folder_open_svgrepo_com, 'folder_open_svgrepo_com',
        ['folder', 'files', 'documents', 'organize']),
    IconMeta(
        notebook_of_contacts_svgrepo_com,
        'notebook_of_contacts_svgrepo_com',
        ['contacts', 'notebook', 'people', 'address book']),
    IconMeta(shopping_cart_list, 'shopping_cart_list',
        ['shopping', 'cart', 'list', 'groceries', 'plan']),
    IconMeta(tasks_cog, 'tasks_cog',
        ['tasks', 'settings', 'automation', 'optimize', 'management']),
    IconMeta(answer_student_svgrepo_com, 'answer_student_svgrepo_com',
        ['student', 'answer', 'quiz', 'learning', 'test']),
  ];
}
