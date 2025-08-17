// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:your_app/feature/chat/domain/entities/message_entity.dart';
// import 'package:your_app/feature/chat/domain/repositories/chat_repository.dart';
// import 'package:your_app/feature/chat/domain/usecases/get_chats_usecase.dart';

// class MockChatRepository extends Mock implements ChatRepository {}

// void main() {
//   late GetChatsUseCase usecase;
//   late MockChatRepository mockRepository;

//   setUp(() {
//     mockRepository = MockChatRepository();
//     usecase = GetChatsUseCase(mockRepository);
//   });

//   const tMessages = [
//     MessageEntity(
//       id: '1',
//       senderId: 'user1',
//       receiverId: 'user2',
//       content: 'Hi',
//       timestamp: 1111111,
//     ),
//     MessageEntity(
//       id: '2',
//       senderId: 'user2',
//       receiverId: 'user1',
//       content: 'Hello',
//       timestamp: 1111112,
//     ),
//   ];

//   test('should get chat messages from repository', () async {
//     // arrange
//     when(
//       () => mockRepository.getChats('user1', 'user2'),
//     ).thenAnswer((_) async => tMessages);

//     // act
//     final result = await usecase(
//       const ChatParams(userId: 'user1', peerId: 'user2'),
//     );

//     // assert
//     expect(result, tMessages);
//     verify(() => mockRepository.getChats('user1', 'user2')).called(1);
//     verifyNoMoreInteractions(mockRepository);
//   });
// }
