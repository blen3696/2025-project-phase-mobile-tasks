// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:your_app/feature/chat/domain/entities/message_entity.dart';
// import 'package:your_app/feature/chat/domain/repositories/chat_repository.dart';
// import 'package:your_app/feature/chat/domain/usecases/send_message_usecase.dart';

// class MockChatRepository extends Mock implements ChatRepository {}

// void main() {
//   late SendMessageUseCase usecase;
//   late MockChatRepository mockRepository;

//   setUp(() {
//     mockRepository = MockChatRepository();
//     usecase = SendMessageUseCase(mockRepository);
//   });

//   const tMessage = MessageEntity(
//     id: '123',
//     senderId: 'user1',
//     receiverId: 'user2',
//     content: 'Hello there!',
//     timestamp: 1234567890,
//   );

//   test(
//     'should call repository to send a message and return true on success',
//     () async {
//       // arrange
//       when(
//         () => mockRepository.sendMessage(tMessage),
//       ).thenAnswer((_) async => true);

//       // act
//       final result = await usecase(tMessage);

//       // assert
//       expect(result, true);
//       verify(() => mockRepository.sendMessage(tMessage)).called(1);
//       verifyNoMoreInteractions(mockRepository);
//     },
//   );
// }
