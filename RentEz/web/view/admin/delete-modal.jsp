<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- Delete Confirmation Modal -->
<div id="deleteModal" class="fixed inset-0 bg-black bg-opacity-50 hidden overflow-y-auto h-full w-full z-50">
    <div class="relative top-20 mx-auto p-5 border w-96 shadow-lg rounded-xl bg-white">
        <div class="mt-3 text-center">
            <div class="w-16 h-16 bg-red-100 rounded-full flex items-center justify-center mx-auto mb-4">
                <i class="fas fa-exclamation-triangle text-red-500 text-2xl"></i>
            </div>
            <h3 class="text-lg font-semibold text-gray-900 mb-2">Xác nhận xóa</h3>
            <p class="text-sm text-gray-600 mb-6">
                Bạn có chắc chắn muốn xóa <span id="deleteName" class="font-semibold text-red-600"></span>?
                <br>Hành động này không thể hoàn tác.
            </p>
            
            <div class="flex justify-center space-x-3">
                <button type="button" onclick="closeDeleteModal()" 
                        class="px-6 py-2 bg-gray-300 text-gray-700 rounded-lg hover:bg-gray-400 transition-colors">
                    Hủy
                </button>
                <form method="post" action="${pageContext.request.contextPath}/admin/delete-action" class="inline">
                    <input type="hidden" name="id" id="deleteId">
                    <input type="hidden" name="type" id="deleteType">
                    <button type="submit" 
                            class="px-6 py-2 bg-gradient-to-r from-red-500 to-red-600 text-white rounded-lg hover:from-red-600 hover:to-red-700 transition-all">
                        <i class="fas fa-trash mr-2"></i>Xóa
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    function closeDeleteModal() {
        document.getElementById('deleteModal').classList.add('hidden');
    }
</script>
